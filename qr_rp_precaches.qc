// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY PRECACHES
// *******
void() W_Precache;
void() RP_SetPrecaches =
{
	W_Precache();
	
	// Models
	precache_model ("progs/rp_money.mdl");
	precache_model ("progs/rp_printer.mdl");
	precache_model ("progs/rp_melon.mdl");
	precache_model ("progs/rp_ball.mdl");
	
	// Sounds
	precache_sound ("roleplay/bounce.wav");
	precache_sound ("roleplay/rave.wav");
	precache_sound ("roleplay/lockdown.wav");
};
