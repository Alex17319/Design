
resolution = 15;
previewDist = 200; // 200 for full model

$fn = resolution;

module trackThin() {
    import(file = "Flame tracks 2d v2 export-05mm-segmented.svg", dpi = 25.4/10);
}

module track9mm() {
    import("Flame tracks 2d v2 export-9mm.svg");
}

module trackThinExtruded() {
    linear_extrude(0.1, convexity = 10) trackThin();
}

module track9mmExtruded() {
    linear_extrude(8, convexity = 10) track9mm();
}

module trackThinExtrudedCropped() {
    intersection() {
        translate([0,0,-1])
            cube([200,previewDist,20]);
        trackThinExtruded();
    }
}

module carving() {
    minkowski(convexity=5) {
        //cube(size=5, center=true);
        sphere(d=5);
        trackThinExtrudedCropped();
    }
}

module carvedTrack() {
    difference() {
        track9mmExtruded();
        //cube([200,200,8]);
        translate([0,0,8]) carving();
        //translate([5,5,5]) track9mmExtruded();
    }
}

//track9mmExtruded();
//carving();
carvedTrack();
