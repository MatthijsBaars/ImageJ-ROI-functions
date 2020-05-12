title = getTitle();
id = getImageID();
path = getDirectory("image");
imagename = substring(title, 0, indexOf(title, "_comp.tiff"));

if (roiManager("count") > 0){
	savename = path + imagename + "_rois.zip";
	roiManager("save", savename);

	// save overlay
	selectImage(id);
	run("From ROI Manager");
	run("Overlay Options...", "stroke=red width=2 fill=none set apply");
	saveAs("PNG", path + imagename + "_overlay.png");
	roiManager("reset");
	selectImage(id);
	close();
}else {
	print("No rois found");
}
