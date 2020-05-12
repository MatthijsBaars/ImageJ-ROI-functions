path = getDirectory("Choose a Directory");
exportpath = path + "/export/";

filelist = getFileList(path);

run("Set Measurements...", "area mean standard modal display redirect=None decimal=3");
roiManager("reset");
run("Clear Results");

for (i = 0; i < filelist.length; i++) {
	if (endsWith(filelist[i], ".ome.tiff")) {
		shorttitle = substring(filelist[i], 0, indexOf(filelist[i], ".ome.tiff"));
		roifile = exportpath + shorttitle + "_rois.zip";
		if (File.exists(roifile)){
			open(path + filelist[i]);
			id = getImageID();
			roiManager("open", roifile);
			roiManager("show all with labels");
			roiManager("multi-measure measure_all");
			saveAs("Results", exportpath + shorttitle + "_Results.csv");
			selectImage(id);
			close();
			selectWindow("Results");
			run("Close");
		}else {
			print("No rois found");
		}
	}
}
showMessage("All done");