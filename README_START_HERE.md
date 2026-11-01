# MCF-7 project — code and results archive

Project: Spatial Reorganization of Actin and Microtubules and Its Association with Nuclear Morphology in Drug-Treated MCF-7 Cells.

## What is included

- `01_Code`: the actual Fiji/ImageJ macros (v3 is the last version used) and the Python dataset-extraction script; older macro versions kept separately for provenance.
- `02_Dataset_Manifests`: original selection manifests and BBBC021 image inventory.
- `03_Full_Batch_Results`: **full per-nucleus measurements for 8,435 detected objects** (30 columns), the **48-row per-field QC CSV**, group/plate summaries, six result figures and scientific caveats. This is the main analytical result folder.
- `04_Pilot_and_Manual_Method_Development`: the original pilot runs, validation comparisons, saved pilot mask and nuclear ROI ZIP, single-nucleus measurements and historical/unvalidated test exports.
- `05_Representative_Microscopy_and_Fiji_Images`: selected representative original TIFF channel files for three treatments (Plate 1), montage, Fiji screenshots and image QC evidence.
- `06_Manual_Validation_Plate2`: manually processed DMSO, Cytochalasin B and Taxol fields, images/overlays, Results and available ROI ZIPs and QC summaries.
- `07_Original_Exports_and_Legacy_Results`: original as-received CSV/ROI files retained so no original export has been silently replaced.
- `08_Final_Summary`: the two-page scientific results summary PDF.
- `FILE_MANIFEST_SHA256.csv`: an inventory with SHA256 checksums for archive contents.

## Start here

1. Open `03_Full_Batch_Results/01_Raw_Results/MCF7_per_nucleus_FULL_BATCH_v3.csv` and `MCF7_per_field_FULL_BATCH_v3.csv`.
2. Review `03_Full_Batch_Results/02_Treatment_and_Plate_Summaries` and `03_Full_Batch_Results/03_Figures`.
3. Open the Fiji macro `01_Code/Current_Main_Macro/MCF7_Fiji_pilot_then_batch_QC_v3.ijm`. It defaults to `PILOT_MODE = true`; set it to `false` only when running a complete batch on properly arranged source images, in an empty output folder.
4. Use `01_Code/Data_Extraction/extract_BBBC021_selected.py` and the manifests to reconstruct the exact selected TIFF folder from official BBBC021 plate image ZIPs stored on your computer.

## Scientific and technical caveats

- These are **segmented nuclear objects**, not verified live cells, and the project did not directly measure drug effectiveness or cell death.
- Full-batch counts: DMSO 5,678, Cytochalasin B 1,497, Taxol 1,260 = 8,435 objects. Strict automated QC retained 1,694, 139 and 134, respectively (1,967 total).
- The full-batch per-field CSV has 48 entries, but the `analysis_status` column says `PILOT_NOT_QC_VALIDATED` in every row; this reflects the source macro's output label, **not** evidence that the file contains only one field. We have preserved this original label rather than silently altering the CSV.
- Morphology-screened totals: DMSO 4,718; Cytochalasin B 1,132; Taxol 634. Strong imbalance in strict QC acceptance means treatment-level perinuclear fluorescence comparisons are sensitive to ROI selection.
- Fiji's output pixel distances are not converted to micrometres because physical pixel calibration was not established. Rings are 0–8 and 8–16 pixels outside nuclear ROIs; background estimated at the field/channel 10th percentile in the automated macro.
- Some `04_Pilot_and_Manual_Method_Development/04_Historical_Pilot_Exports` files are explicitly labelled UNVALIDATED/UNTESTED. Do not present those historical trial results as final batch results.
- The 144 original TIFF images from all 48 fields are **not all available in this conversation**. This ZIP includes 9 representative source-channel TIFFs and the full selection manifests, not the complete original 144-image collection. The original plate ZIPs must be provided/downloaded separately to rerun the entire extraction/batch pipeline.
- The original manual Cytochalasin B ROI ZIP was not found among available files; its visual evidence and measurements are included.

## Dataset attribution

BBBC021, Broad Bioimage Benchmark Collection (public source microscopy data). Source data should be obtained from the official BBBC021 page and metadata.

## Notes on completeness

This package consolidates code and result files that were accessible in this conversation. Earlier redundant screenshot-checkpoint ZIP versions and the PowerPoint/video files are excluded because this is a **code-and-results** archive, not a media or presentation backup.
