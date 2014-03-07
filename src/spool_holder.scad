// models-spool_stand
// 3D Printing Filament Spool Stand
// GNU GPL v3
// Ethan Sherman <ethan@blackguest.net>
//
// https://github.com/blackguest/models-spool_stand

spool_r = 100;
spool_w = 70;
spool_lip = 5;

double_m4_washers = 1.65;
bearing_w = 5;
bearing_gap = double_m4_washers + bearing_w;
bearing_id = 4.1;
bearing_r = 6.5;

base_thickness = 5;

fudge = 0.01;

module spool(){
    // TODO: make a more accurate spool model.
    $fn=180;
    rotate([90,0,0])
      cylinder(r=spool_r,h=spool_w);
}

module base_sides(){
  // OUTER back left bearing mount side
  translate([-spool_r/2-bearing_w*2,-bearing_gap/2-base_thickness,0])
    cube([bearing_w*4,base_thickness,bearing_w*8]);
  // INNER back right bearing mount side
  translate([-spool_r/2-bearing_w*2,bearing_gap/2,0])
    cube([bearing_w*4,base_thickness,bearing_w*6]);
  // OUTER front left bearing mount side
  translate([spool_r/2-bearing_w*2,-bearing_gap/2-base_thickness,0])
    cube([bearing_w*4,base_thickness,bearing_w*8]);
  // INNER front right bearing mount side
  translate([spool_r/2-bearing_w*2,bearing_gap/2,0])
    cube([bearing_w*4,base_thickness,bearing_w*6]);
}

module base(){
    $fn=360;
    union(){
      // back foot
      translate([-spool_r/2,0,0])
        cylinder(r=bearing_w*4, h=base_thickness);
      // front foot
      translate([spool_r/2,0,0])
        cylinder(r=bearing_w*4, h=base_thickness);
      // connect the feet
      difference(){
        translate([-spool_r/2,-bearing_w*4/2,0])
            cube([spool_r, bearing_w*4, base_thickness]);
        translate([-spool_r/2,-bearing_w*1/2,0])
            cube([spool_r, bearing_w+fudge, base_thickness+fudge]);
      }
      // holes for bearing shaft bolts
      difference(){
        base_sides();
        translate([spool_r/2,bearing_w*4,bearing_w*4-bearing_w+base_thickness])
          rotate([90,0,0])
            cylinder(r=bearing_id/2, h=bearing_w*8);
        translate([-spool_r/2,bearing_w*4,bearing_w*4-bearing_w+base_thickness])
          rotate([90,0,0])
            cylinder(r=bearing_id/2, h=bearing_w*8);
      }
    }
}

//translate([0,spool_w,spool_r + base_thickness+bearing_r])
//  spool();

difference(){
  base();
  translate([0,spool_w,spool_r + base_thickness+bearing_r+spool_lip])
    spool();
}
