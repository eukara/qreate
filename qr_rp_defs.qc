// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY DEFINITONS
// *******
//
// Feel free to add extra jobs and weapon definitions!

// Jobs:
float   JOB_CITIZEN		= 1001;
float   JOB_POLICEFORCE	= 1002;
float   JOB_MOBSTER		= 1004;
float   JOB_GUNDEALER	= 1005;
float   JOB_MEDIC		= 1006;
float   JOB_MERCHANT		= 1007;
float   JOB_MAYOR		= 1008;
//float   JOB_EXTRA		= 1009;
.string	TITLE_JOB_CITIZEN;
.string	TITLE_JOB_POLICEFORCE;
.string	TITLE_JOB_MOBSTER;
.string	TITLE_JOB_GUNDEALER;
.string	TITLE_JOB_MEDIC;
.string	TITLE_JOB_MERCHANT;
.string	TITLE_JOB_MAYOR;
//string	TITLE_JOB_EXTRA;

// Weapons (continued from Line 321)
float   IT_KEYS			= 8388608;
//float   IT_EXTRA_TOOL	= 16777216;

// Player Definitions:
.float	rp_job;
.float	rp_money;
.float	rp_salary;
.float	rp_inmenu;
.float	rp_infmenu;
.float	rp_menutime;
.string	rp_title;

// Entity definitions:
.entity	rp_owner;
.entity rp_payday;
.entity rp_lockdownspeaker;
.float rp_locked;
float rp_lockdown;
void(entity client, string s1, string s2, string s3, string s4) lightrp_centerprint = #73;
void(entity client, string s1, string s2, string s3, string s4, string s5, string s6, string s7, string s8, string s9, string s10, string s11, string s12, string s13, string s14, string s15) lightrp_centerprintb = #73;

