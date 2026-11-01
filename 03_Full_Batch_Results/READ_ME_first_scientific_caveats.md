# MCF-7 batch data: preliminary scientific interpretation (25 Oct 2026)

INPUTS: User-supplied ImageJ macro v3 CSVs for all 48 microscopy fields, 3 plate replicates, four wells per plate (B02/D02 DMSO; B05 cytochalasin B; D05 Taxol). No drug-treated raw TIFFs were available for image-level QC in this analysis.

PROCESSING VERIFICATION: 48 unique fields and 8435 detected nuclear objects; counts agree exactly between field and per-nucleus CSVs. Macro labels every field PILOT_NOT_QC_VALIDATED. Passing automated flags is a screening outcome, not independent segmentation validation.

QC: Strict ring QC (small-object, image edge, ring overlap with other nuclear masks, positive channel-corrected signals) retained 1694/5678 (29.8%) DMSO, 139/1497 (9.3%) cytochalasin B, and 134/1260 (10.6%) Taxol. This severe differential selection requires caution and representative images from all conditions. Morphology-only analysis may use size >= 100 px^2 and edge ring flag=0, but nuclear segmentation itself needs visual QC.

MORPHOLOGY: Three plate-level medians (DMSO pooled equally across B02 and D02 wells) show lower nuclear circularity and solidity in drug groups than controls. Descriptive results, no inferential p values because only 3 plate-level replicates/group and biological independence of plates is not confirmed.

CYTOSKELETAL: Strict QC perinuclear inner/outer fluorescence ratios are larger in treated groups, but effect sizes and even direction for cytochalasin B Tubulin relative to DMSO change sharply if neighboring-nucleus ring-overlap exclusion is relaxed. These results are currently QC-sensitive, not established proof of a drug-induced spatial redistribution. Different staining channels cannot be compared directly as protein abundances. Fixed-cell images cannot show movement/causal cytoskeletal forces.

FURTHER VALIDATION PRIOR TO PRESENTATION CLAIMS: Inspect at least one DMSO, one B05 and one D05 field (DAPI, Actin, Tubulin), overlay segmentation and rings, verify small/irregular nuclei against raw fluorescence, quantify image saturation/background variation and report plate/well-level summaries. With three plates and few independent wells, emphasize descriptive pattern and limitations.

FIGURES: 01 QC retention; 02 circularity across plates (size+edge QC); 03 solidity across plates (size+edge QC); 04 Actin ratio by strict vs sensitivity selection; 05 Tubulin ratio by strict vs sensitivity selection; 06 detected objects per field. Figures are preliminary, not validated biological conclusions.
