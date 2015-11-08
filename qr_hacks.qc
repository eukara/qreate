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

void() InitTrigger;

#define LADDER_MOVESPEED	400
void() ladder_touch =
{
	local vector vel, pvec;
	float fvel, spd;
	
	if (other.classname != "player") 
		return;
	if (other.waterlevel > 1) 
		return;
	if (other.flags & FL_WATERJUMP) 
		return;
	
	
	makevectors (other.v_angle);
	pvec = v_forward;
	pvec = (pvec * 250);

	if (other.button2)
		other.velocity = pvec;
	
	// Don't re-grab right away if jumping
	if (other.ladderjump > time) return;
	
	// Check if the player can grab the ladder
	makevectors (other.angles);
	if (v_forward*self.movedir<-0.5)// a little more than 180¿ of freedom
		return;// not facing the right way
	
	// Avoid problems if the player is on the top edge (act like an 8 unit step)
	if (other.origin_z + other.mins_z + 8 >= self.absmax_z) {
		if ((!other.flags & FL_ONGROUND))
			other.flags = other.flags + FL_ONGROUND;
		return;
	}

	other.laddertime = other.zerogtime = time + 0.1;
	other.velocity_z = 0;
		
	if (v_right*other.velocity > 25) {
		other.velocity = '0 0 0';
		other.origin = other.origin + v_right*0.5;
		return;
	}
	else if (v_right*other.velocity < -25) {
		other.velocity = '0 0 0';
		other.origin = other.origin - v_right*0.5;
		return;
	}

	fvel = v_forward*other.velocity;
	vel = '0 0 0';
	
	if (other.v_angle_x <= 15 && fvel>0 ) {
		other.origin = other.origin - self.movedir*0.36;
		vel_z = fabs(other.v_angle_x)*6;	
		if (vel_z < 90) vel_z = 90;
	}
 	else if ( other.v_angle_x >= 15 && fvel<0 ) {
		other.origin = other.origin + self.movedir*0.36;
		vel_z = other.v_angle_x*4;
	}
	else if (other.v_angle_x <= 15 && fvel<0 ) {	
		other.origin = other.origin + self.movedir*0.36;
		vel_z = fabs(other.v_angle_x)*-5;
		if (vel_z > -80) vel_z = -80;
	}
	else if ( other.v_angle_x >= 15 && fvel>0 ) {		
		other.origin = other.origin - self.movedir*0.36;
		vel_z = other.v_angle_x*-4;
	}

	if (vel_z > 150) 
		vel_z = 150;
	else if (vel_z < -1*150) vel_z = -1*150;
		other.velocity = vel;
};

void() qreate_ladder =
{
	InitTrigger();
	self.touch = ladder_touch;
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
	local float r;
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
