// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

float() qreate_CheckHIPNOTIC =
{
	if(mapname == "hip1m1" ||
		mapname == "hip1m2" ||
		mapname == "hip1m3" ||
		mapname == "hip1m4" ||
		mapname == "hip1m5" ||
		mapname == "hip2m1" ||
		mapname == "hip2m2" ||
		mapname == "hip2m3" ||
		mapname == "hip2m4" ||
		mapname == "hip2m5" ||
		mapname == "hip2m6" ||
		mapname == "hip3m1" ||
		mapname == "hip3m2" ||
		mapname == "hip3m3" ||
		mapname == "hip3m4" ||
		mapname == "hipdm1" ||
		mapname == "hipend")
		return TRUE;
	else
		return FALSE;
};

float() qreate_CheckROGUE =
{
	if(mapname == "ctf1" ||
		mapname == "r1m1" ||
		mapname == "r1m2" ||
		mapname == "r1m3" ||
		mapname == "r1m4" ||
		mapname == "r1m5" ||
		mapname == "r1m6" ||
		mapname == "r1m7" ||
		mapname == "r2m1" ||
		mapname == "r2m2" ||
		mapname == "r2m3" ||
		mapname == "r2m4" ||
		mapname == "r2m5" ||
		mapname == "r2m6" ||
		mapname == "r2m7" ||
		mapname == "r2m8" )
		return TRUE;
	else
		return FALSE;
};

float() qreate_CheckSANDBOX =
{
	if(!world.mode)
		return TRUE;
	else
		return FALSE;
};

float() qreate_CheckLIGHTRP =
{
	if(world.mode == 2)
		return TRUE;
	else
		return FALSE;
};

float() qreate_CheckCOMMANDO =
{
	if(world.mode == 3)
		return TRUE;
	else
		return FALSE;
};

void() qreate_arcade =
{
	if(!(self.model))
		self.model = "progs/qrcad1.mdl";
		
	precache_model (self.model);
	
	if(self.noise)
		precache_sound(self.noise);
		
	setmodel(self, self.model);
	self.skin = 0;
	
	if(self.noise)
		ambientsound (self.origin, self.noise, 1.0, ATTN_IDLE);
};

void() qreate_serversidenoclip =
{
	if(self.movetype == MOVETYPE_NOCLIP)
	{
		self.movetype = MOVETYPE_WALK;
		sprint(self, "noclip off\n");
	}
	else
	{
		self.movetype = MOVETYPE_NOCLIP;
		sprint(self, "noclip on\n");
	}
};

void(entity player) qreate_cleanup =
{
	local entity    finder;

        finder = findradius (self.origin, 20000);

        while(finder) 
        {
                if(finder.spawner == player)
			remove(finder);

                finder = finder.chain;
        }
};

void() qreate_model =
{
	precache_model(self.model);
	setmodel(self, self.model);
};

void() qreate_ladder_touch =
{
	if(other.classname == "player")
	other.velocity_z = other.velocity_z + 10;
};

// Not a REAL ladder, just a HACK!
void() qreate_ladder =
{
	self.solid = SOLID_TRIGGER;
	setmodel (self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
	self.touch = qreate_ladder_touch;
};

void() player_stand1;
void() qreate_hack_fakeplayer =
{
	setmodel(self, "progs/player.mdl");
	self.solid = SOLID_BBOX;
	setsize (self, '-16 -16 -24', '16 16 40');
	player_stand1();
};

void() qreate_tree =
{
	float r;
	r = random();
	
	if(r < 0.25)
		self.model = "progs/tree1.spr";
	else if(r < 0.5)
		self.model = "progs/tree4.spr";
	else if(r < 0.75)
		self.model = "progs/tree5.spr";
	else
		self.model = "progs/tree3.spr";

	precache_model(self.model);
	setmodel(self, self.model);
	self.solid = SOLID_BBOX;
	setsize (self, '-16 -16 -24', '16 16 40');
};
