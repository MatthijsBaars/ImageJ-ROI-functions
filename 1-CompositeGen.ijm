path = getDirectory("Choose a Directory");
exportpath = path + "/export/";

suffix = ".ome.tiff";

// Number of channel to put to color
c1 = NaN; //red
c2 = 1; //green
c3 = NaN; //blue
c4 = NaN; //gray
c5 = NaN; //cyan
c6 = 2; //magenta
c7 = NaN; //yellow

if (!File.exists(exportpath)) {
	File.makeDirectory(exportpath);
}

setBatchMode(true);

filelist = getFileList(path);
compositeChannels = newArray(c1,c2,c3,c4,c5,c6,c7);
for (i = 0; i < filelist.length; i++) {
	if (endsWith(filelist[i], suffix)) {
		open(path + filelist[i]);
		rename("stack");
		id = getImageID();
		compositeid = createComposite(id, compositeChannels);
		selectImage(id);
		close();
		savetitle = substring(filelist[i], 0, indexOf(filelist[i], suffix)) + "_comp.tiff";
		selectImage(compositeid);
		saveAs("tiff", exportpath + savetitle);
		close();
	}
}

function createComposite(id, compositeChannels) {	
	c1 = duplicate(id, compositeChannels[0], 1);
	c2 = duplicate(id, compositeChannels[1], 2);
	c3 = duplicate(id, compositeChannels[2], 3);
	c4 = duplicate(id, compositeChannels[3], 4);
	c5 = duplicate(id, compositeChannels[4], 5);
	c6 = duplicate(id, compositeChannels[5], 6);
	c7 = duplicate(id, compositeChannels[6], 7);
	run("Merge Channels...", "c1=["+c1+"] c2=["+c2+"] c3=["+c3+"] c4=["+c4+"] c5=["+c5+"] c6=["+c6+"] c7=["+c7+"] create");
	return getImageID();
}

function duplicate(id, channel, nr){
	channeltitle = "c" + nr;
	if (!isNaN(channel)) {
		selectImage(id);
		Stack.setSlice(channel);
		run("Duplicate...", "title=["+channeltitle+"]");
		run("Enhance Contrast", "saturated=0.35");
		return channeltitle;
	}else{
		return "*None*";
	}
}