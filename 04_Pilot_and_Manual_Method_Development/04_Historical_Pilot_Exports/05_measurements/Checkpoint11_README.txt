CHECKPOINT 11 - BACKGROUND CORRECTION AND PILOT AUTOMATION
Data: BBBC021 Plate Week1_22123 / B02 / site_1, one DMSO nucleus.
Actin three background means: 572.160, 596.760, 605.760; mean 591.560; locations FeretX/FeretY: (71,708), (688,884), (901,808).
Tubulin three background means: 999.320, 1068.720, 1110.120; mean 1059.386667; locations: (64,721), (715,863), (896,760).
The sampled rectangles were NOT at identical coordinates between channels. This is acceptable as a preliminary within-channel background estimate, not strict cross-channel matched ROI analysis.
Actin inner raw 2460.078, outer raw 2612.188, corrected inner 1868.518, corrected outer 2020.628, corrected ratio 0.924721.
Tubulin inner raw 5775.586, outer raw 4048.455, corrected inner 4716.199333, outer 2989.068333, corrected ratio 1.577816.
Macro MCF7_Fiji_pilot_then_batch.ijm is PROVIDED AS AN UNTESTED FIJI DRAFT. Its pilot mode analyzes first field using independently generated Otsu/watershed ROIs, makes outer band from an 8px expanded ROI then 8px Make Band. These may not exactly match manual ROIs. Before batch, test on first DMSO field, compare area, counts, background, bands, and validate a sample of nuclear masks/overlays in Fiji. No claims of Fiji-runtime testing were made. The background in macro is 10th percentile of full image, which for this uploaded control image was separately checked in Python as ~608 for Actin and ~1056 for Tubulin, close to the manually sampled backgrounds.
Biological analysis must respect plate/well hierarchy and systematic conditions, with fields not independent replicates, and exclude unreliable nuclei/rings.
