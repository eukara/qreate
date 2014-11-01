// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

float	COMMANDO_TEAM1			= 0;	// RED
float	COMMANDO_TEAM2			= 1;	// BLUE
float	COMMANDO_TEAM3			= 2;	// GREEN
float	COMMANDO_TEAM4			= 3;	// YELLOW

.float	fTeam;
.float	fTeamEnergy;
.float 	fTeamMaxEnergy;
.float	fTeamResources;
float	fTeamFull;
.float	fInMenu;
.float 	alpha;

float	COMMANDO_OBJ_POWERGENERATOR	= 0;
float	COMMANDO_OBJ_POWERSTORAGE		= 1;
float	COMMANDO_OBJ_LANDCRAFTFACILITY	= 2;
float	COMMANDO_OBJ_AIRCRAFTFACILITY	= 3;
float	COMMANDO_OBJ_BRIDGING			= 4;
float	COMMANDO_OBJ_DEFENSEWALL		= 5;

.float	fSelection;
.float	fSelectionRotation;
.string sSelectionModel;
.entity eSelection;
.entity eCreator;
float   IT_MECHWARRIOR	= 16777216;