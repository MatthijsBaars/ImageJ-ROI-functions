1-CompositeGen.ijm
Use this macro to generate composites from image stacks in a folder.

The script first prompts for which folder to process.
Only files in the selected folder are processed, not the files in subdirectories.
By default only ".ome.tiff" files are included, specified in the variable suffix.

The user should define which slice of the stack to use for which color in the final composite.

An "export" folder is generated in the user-specified folder.
Output is saved to this folder as a multi-channel tiff file.
The generated file is named "[input name w/o extension]_comp.tiff".
Channel intensity is not scaled, but ImageJ display values are.

2-ROIsave.ijm
Use this macro to store selections stored in the ImageJ ROI Manager to a file next to the opened image.
Preferably the image generated with "1-CompositeGen.ijm" should be used!
It is possible to rename rois in the ROI Manager, names will be maintained in results of "3-Measure.ijm".

All rois in the ROI Manager will be saved as "[input name w/o extension]_rois.zip".
Additionally, the rois will be overlayed on the current image and stored as "[input name w/o extension]_overlay.png".
Rois will be deleted from the ROI Manager, and the selected image will be closed after saving.

3-Measure.ijm
Use this macro to measure all rois generated with "2-ROIsave.ijm" on the original image stack.
Specify the same folder as given as input in "1-CompositeGen.ijm".
The folder layout and file-naming will be recognized.

Processing is done in batch mode, consequently there will be limited display of steps.
The script will notify on completion.

All rois will be measured on all slices (channels) in the original stack, results will be saved to "[input name w/o extension]_Results.csv".