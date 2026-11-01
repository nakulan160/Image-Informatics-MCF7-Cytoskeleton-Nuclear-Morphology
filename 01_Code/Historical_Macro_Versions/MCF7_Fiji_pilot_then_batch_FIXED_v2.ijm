// MCF-7 / BBBC021 ImageJ/Fiji quantitative pilot + batch macro (v2: fixes variable scope)
// Data: original 16-bit DAPI, Actin, Tubulin images extracted by the supplied script.
// Does not overwrite any source microscopy files.
// Start in PILOT_MODE=true; verify pilot results against manual measurements before using false.
// Output: ONE per-nucleus CSV and ONE per-field QC CSV in the output folder.
// All band widths are in PIXELS; physical pixel spacing has NOT been established.
// IMPORTANT: ROIs and perinuclear rings require visual QC, especially in crowded cells.

PILOT_MODE = true;          // Change to false ONLY after verifying the first field.
BAND_PX = 8;               // Inner 0-8 pixels; outer 8-16 pixels.
BACKGROUND_PERCENTILE = 0.10; // Pixel-intensity percentile, not a biological reference value.

root = getDirectory("Select BBBC021_selected (48-field image folder)");
out = getDirectory("Choose an EMPTY folder for new analysis outputs");
perNucleus = out + "MCF7_per_nucleus_PILOT_OR_BATCH.csv";
perField = out + "MCF7_per_field_QC.csv";

File.saveString("plate,well,site,condition,roi_index,nuclear_area_px2,nuclear_circularity,nuclear_solidity,edge_ring_flag,small_object_flag,overlaps_other_nuclei_flag,actin_inner_area_px2,actin_outer_area_px2,actin_inner_mean_raw,actin_outer_mean_raw,actin_bg_p10,actin_inner_corrected,actin_outer_corrected,actin_ratio_corrected,tubulin_inner_area_px2,tubulin_outer_area_px2,tubulin_inner_mean_raw,tubulin_outer_mean_raw,tubulin_bg_p10,tubulin_inner_corrected,tubulin_outer_corrected,tubulin_ratio_corrected\n", perNucleus);
File.saveString("plate,well,site,condition,segmented_objects_edge_excluded,actin_bg_p10,tubulin_bg_p10,analysis_status\n", perField);

plates = newArray("Week1_22123", "Week1_22141", "Week1_22161");
wells = newArray("B02", "D02", "B05", "D05");
fieldNumber = 0;

for (p=0; p<plates.length; p++) {
    for (w=0; w<wells.length; w++) {
        for (site=1; site<=4; site++) {
            dir = root + plates[p] + "/" + wells[w] + "/site_" + site + "/";
            if (File.isDirectory(dir)) {
                processField(dir, plates[p], wells[w], site);
                fieldNumber++;
                if (PILOT_MODE) {
                    showMessage("Pilot finished", "Processed ONE field. Compare the output with manual Fiji measurements before switching PILOT_MODE to false.\n\nOutput folder:\n" + out);
                    exit();
                }
            }
        }
    }
}
showMessage("Batch complete", "Fields processed: " + fieldNumber + "\nReview per-field QC and segmentation before biological interpretation.");

function findChannelFile(dir, prefix) {
    names = getFileList(dir);
    for (k=0; k<names.length; k++) {
        if (startsWith(names[k], prefix) && endsWith(toLowerCase(names[k]), ".tif"))
            return dir + names[k];
    }
    return "";
}

function bgPercentile(imageID, fraction) {
    selectImage(imageID);
    run("Select None");
    getHistogram(hvals, hcounts, 65536);
    total = 0;
    for (q=0; q<hcounts.length; q++) total += hcounts[q];
    target = total * fraction;
    cumulative = 0;
    for (q=0; q<hcounts.length; q++) {
        cumulative += hcounts[q];
        if (cumulative >= target) return q;
    }
    return 0;
}

// Returns [area, mean intensity] explicitly; local variables inside this function
// are NOT accessible in processField. Leaves saved nuclear ROI unchanged.
function measureBand(imageID, index, distance, width) {
    selectImage(imageID);
    roiManager("Select", index);
    if (distance > 0) run("Enlarge...", "enlarge=" + distance);
    run("Make Band...", "band=" + width);
    getStatistics(localArea, localMean);
    return newArray(localArea, localMean);
}

function correctedRatio(inner, outer, background) {
    if ((outer - background) <= 0) return "NA";
    return d2s((inner - background) / (outer - background), 6);
}

function conditionOf(well) {
    if (well=="B02" || well=="D02") return "DMSO";
    if (well=="B05") return "Cytochalasin_B";
    if (well=="D05") return "Taxol";
    return "Unknown";
}

function processField(dir, plate, well, site) {
    dapiPath = findChannelFile(dir, "DAPI_");
    actinPath = findChannelFile(dir, "Actin_");
    tubulinPath = findChannelFile(dir, "Tubulin_");
    treatment = conditionOf(well);
    if (dapiPath=="" || actinPath=="" || tubulinPath=="") {
        File.append(plate+","+well+","+site+","+treatment+",0,NA,NA,MISSING_CHANNEL\n", perField);
        return;
    }

    roiManager("reset");
    open(dapiPath); dapiID = getImageID();
    run("Duplicate...", "title=MCF7_Working_DAPI_Mask"); maskID = getImageID();
    setOption("BlackBackground", true);
    setAutoThreshold("Otsu dark");
    run("Convert to Mask");
    run("Fill Holes");
    run("Watershed");

    run("Set Measurements...", "area perimeter shape redirect=None decimal=6");
    run("Analyze Particles...", "size=0-Infinity circularity=0.00-1.00 show=Nothing display clear exclude add");
    n = roiManager("count");
    areas = newArray(n);
    circles = newArray(n);
    solidities = newArray(n);
    for (i=0; i<n; i++) {
        areas[i] = getResult("Area", i);
        circles[i] = getResult("Circ.", i);
        solidities[i] = getResult("Solidity", i);
    }
    open(actinPath); actinID = getImageID();
    open(tubulinPath); tubulinID = getImageID();
    bgA = bgPercentile(actinID, BACKGROUND_PERCENTILE);
    bgT = bgPercentile(tubulinID, BACKGROUND_PERCENTILE);
    File.append(plate+","+well+","+site+","+treatment+","+n+","+bgA+","+bgT+",PILOT_NOT_QC_VALIDATED\n", perField);

    textRows = "";
    for (i=0; i<n; i++) {
        selectImage(maskID);
        roiManager("Select", i);
        getSelectionBounds(rx, ry, rw, rh);
        edgeFlag = 0;
        if (rx < 2*BAND_PX || ry < 2*BAND_PX ||
            rx+rw > getWidth()-2*BAND_PX || ry+rh > getHeight()-2*BAND_PX)
            edgeFlag = 1;
        smallFlag = 0;
        if (areas[i]<100) smallFlag = 1; // flagged, NOT automatically discarded

        measurement = measureBand(actinID, i, 0, BAND_PX);
        aiArea = measurement[0]; ai = measurement[1];
        measurement = measureBand(actinID, i, BAND_PX, BAND_PX);
        aoArea = measurement[0]; ao = measurement[1];
        measurement = measureBand(tubulinID, i, 0, BAND_PX);
        tiArea = measurement[0]; ti = measurement[1];
        measurement = measureBand(tubulinID, i, BAND_PX, BAND_PX);
        toArea = measurement[0]; to = measurement[1];

        // A nonzero white-mask signal in a band suggests another nucleus is nearby.
        // This flag is for REVIEW; it cannot detect contamination by neighboring cytoplasm.
        measurement = measureBand(maskID, i, 0, BAND_PX);
        nearInner = measurement[1];
        measurement = measureBand(maskID, i, BAND_PX, BAND_PX);
        nearOuter = measurement[1];
        overlapFlag = 0;
        if (nearInner>0 || nearOuter>0) overlapFlag=1;

        aratio = correctedRatio(ai, ao, bgA);
        tratio = correctedRatio(ti, to, bgT);
        textRows += plate+","+well+","+site+","+treatment+","+(i+1)+","+
            d2s(areas[i],3)+","+d2s(circles[i],6)+","+d2s(solidities[i],6)+","+
            edgeFlag+","+smallFlag+","+overlapFlag+","+
            d2s(aiArea,3)+","+d2s(aoArea,3)+","+d2s(ai,3)+","+d2s(ao,3)+","+bgA+","+
            d2s(ai-bgA,3)+","+d2s(ao-bgA,3)+","+aratio+","+
            d2s(tiArea,3)+","+d2s(toArea,3)+","+d2s(ti,3)+","+d2s(to,3)+","+bgT+","+
            d2s(ti-bgT,3)+","+d2s(to-bgT,3)+","+tratio+"\n";
    }
    File.append(textRows, perNucleus);
    selectImage(tubulinID); close();
    selectImage(actinID); close();
    selectImage(maskID); close();
    selectImage(dapiID); close();
    roiManager("reset");
    run("Clear Results");
    print("Processed: " + plate + "/" + well + "/site_" + site + "  (ROIs=" + n + ")");
}
