// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

float SVC_SETVIEWPORT = 5;
float SVC_SETVIEWANGLES = 10;

.vector view_oldangles;

.float selected;
.float tselected;
.float reversem;
.float secfire;
.float view_fov;

.entity cam;
.float cammode;
.float qmode;
.entity spawner;
.float inveh;
.float mode;
.float stack;

.float qreate_altmenulst;
.float qreate_altmenu;

.float qreate_altmenulstt;
.float qreate_altmenut;
.float qmsg;
.float qreate_bosscnt;
.float qreate_modify;

float SVC_UPDATESTAT = 3;
float STAT_TOTALMONSTERS = 12;