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

.float qreate_bosscnt;
.string qreate_team;
.entity qreate_monster_target;

.float qreate_modify;
.float qmsg;

float	FL_WIRE			= 8192;
float	FL_WIREGATE			= 16384;
.float qreate_wire;
.entity qreate_wireent; // Memorize which entity we are working with
.entity qreate_wirein1; // First Input
.entity qreate_wirein2; // Second Input
.float qreate_wireout; // Output (either 0 or 1)
.float qreate_wireinput; // Controls which input it is serving right now
.float qreate_wire_maxmode;

float SVC_UPDATESTAT = 3;
float STAT_TOTALMONSTERS = 12;

// qr_ladder by pox
.float ladderjump;
.float laddertime;
.float zerogtime;
.float gravity;
.float oldgravity;
