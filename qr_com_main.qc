// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!
void() W_Precache;
void() Commando_Main =
{
	W_Precache();
	precache_model ("progs/debris.mdl");
	precache_model ("progs/v_mech.mdl");
	precache_model ("progs/lpcar1.mdl");
	precache_model ("progs/lpcar1w.mdl");
	precache_model ("progs/lpcar1c.mdl");
	precache_model ("progs/lpplayer.mdl");
	precache_sound ("commando/bloop.wav");
	precache_sound ("commando/carexplo1.wav");
	precache_sound ("commando/carexplo2.wav");
	precache_sound ("commando/land.wav");
	precache_sound ("commando/land2.wav");
	precache_sound ("commando/h2ojump.wav");
	precache_sound ("commando/plyrjmp8.wav");
	precache_sound ("commando/ratling1.wav");
	precache_sound ("commando/ratling2.wav");
};

void() Commando_UpdateView =
{
};

void() Commando_ViewStats =
{
	string sTemp;
	
	sTemp = ftos(self.fTeamEnergy);
	sprint(self, sTemp);
	sprint(self, "\n");
	if(self.fTeam == 0)
		centerprint(self, "You are on TEAM 1\n");
	if(self.fTeam == 1)
		centerprint(self, "You are on TEAM 2\n");
	if(self.fTeam == 2)
		centerprint(self, "You are on TEAM 3\n");
	if(self.fTeam == 3)
		centerprint(self, "You are on TEAM 4\n");
};

void() Commando_SelectionRotatePlus =
{
	self.fSelectionRotation = self.fSelectionRotation + 45;
	
	if(self.fSelectionRotation > 360)
		self.fSelectionRotation = 45;
};

void() Commando_SelectionRotateMinus =
{
	self.fSelectionRotation = self.fSelectionRotation - 45;
	
	if(self.fSelectionRotation < 0)
		self.fSelectionRotation = 315;
};

void() Commando_ToggleMenu =
{
	if(self.fInMenu)
		self.fInMenu = FALSE;
	else
		self.fInMenu = TRUE;
		
};

void() Commando_UpdatePositions =
{
	if(self.fInMenu == FALSE)
		return;
		
	local	vector	vSrc;
	
	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*512, FALSE, self);
	
	if(trace_ent != world)
		return;
		
	setorigin(self.eSelection, trace_endpos);
	self.eSelection.angles_y = self.fSelectionRotation;
};

void() Commando_DisplayMenu =
{
	if(self.fInMenu == FALSE)
		return;
		
	if(!self.sSelectionModel)
		self.sSelectionModel = "progs/compowergen.mdl";
	if(!self.eSelection.alpha)
		self.eSelection.alpha = 0.8;
		
	setmodel(self.eSelection, self.sSelectionModel);
	centerprint(self, "1) Power Generator                   \n2) Power Storage                     \n3) Landcraft Facility                \n4) Aircraft Facility                 \n5) Bridging Block                    \n");
};

void(float fSel) Commando_Selection =
{
	self.fSelection = fSel;
	
	if(self.fSelection == COMMANDO_OBJ_POWERGENERATOR)
		self.sSelectionModel = "progs/compowergen.mdl";
	if(self.fSelection == COMMANDO_OBJ_POWERSTORAGE)
		self.sSelectionModel = "progs/compowerstor.mdl";
	if(self.fSelection == COMMANDO_OBJ_LANDCRAFTFACILITY)
		self.sSelectionModel = "progs/comlandfac.mdl";
	if(self.fSelection == COMMANDO_OBJ_AIRCRAFTFACILITY)
		self.sSelectionModel = "progs/comairfac.mdl";
	if(self.fSelection == COMMANDO_OBJ_BRIDGING)
		self.sSelectionModel = "progs/combridge.mdl";
	if(self.fSelection == COMMANDO_OBJ_DEFENSEWALL)
		self.sSelectionModel = "progs/comdefwall.mdl";
		
	setmodel(self.eSelection, self.sSelectionModel);
	self.eSelection.alpha = 0.8;
};

void() Commando_PowerGenerator_Think =
{
	if(self.eCreator.fTeamEnergy >= self.eCreator.fTeamMaxEnergy)
		return;
	
	self.eCreator.fTeamEnergy = self.eCreator.fTeamEnergy + 1;
	self.nextthink = time + 4;
	sound (self, CHAN_VOICE, "commando/bloop.wav", 1, ATTN_NORM);
};
void() Commando_PowerGenerator_Death =
{
	remove(self);
};

void() Commando_PowerStorage_Think =
{
	self.eCreator.fTeamMaxEnergy = self.eCreator.fTeamEnergy + 20;
};
void() Commando_PowerStorage_Death =
{
	remove(self);
};

void() Commando_BuildThink =
{
	if(self.alpha >= 1)
	{
		stuffcmd(self.eCreator, "play commando/built.wav\n");
		centerprint(self.eCreator, "BUILD COMPLETED");
		
		if(self.style == COMMANDO_OBJ_POWERGENERATOR)
		{
			self.takedamage = DAMAGE_AIM;
			self.health		= 1000;
			self.think = Commando_PowerGenerator_Think;
			self.th_die = Commando_PowerGenerator_Death;
			self.nextthink = time + 1;
		}
		else if(self.style == COMMANDO_OBJ_POWERSTORAGE)
		{
			self.takedamage = DAMAGE_AIM;
			self.health		= 1000;
			self.think = Commando_PowerStorage_Think;
			self.th_die = Commando_PowerStorage_Death;
			self.nextthink = time + 1;
		}
		return;
	}
	setorigin(self, self.origin + '0 0 3');
	self.alpha = self.alpha + 0.05;
	self.nextthink = time + 0.2;
};

void() Commando_PlaceSelection =
{	
	entity ePlaced;
	ePlaced = spawn();
	setmodel(ePlaced, self.sSelectionModel);
	setorigin(ePlaced, self.eSelection.origin + '0 0 -60');
	ePlaced.angles_y = self.fSelectionRotation;
	ePlaced.alpha = 0.01;
	ePlaced.think = Commando_BuildThink;
	ePlaced.nextthink = time + 1;
	ePlaced.eCreator = self;
	ePlaced.style = self.fSelection;
	ePlaced.solid = SOLID_BBOX;
	
	self.fInMenu = FALSE;
	self.eSelection.alpha = 0;
	setmodel(self.eSelection, "");
	centerprint(self, "\n");
};

// For use in PutClientInServer:
void() CommandoPutClient =
{
	// Automatic team selection ~eukos
	if(!fTeamFull)
		self.fTeam = COMMANDO_TEAM1;
	else if(fTeamFull == 1)
		self.fTeam = COMMANDO_TEAM2;
	else if(fTeamFull == 2)
		self.fTeam = COMMANDO_TEAM3;
	else if(fTeamFull == 3)
		self.fTeam = COMMANDO_TEAM4;
	
	fTeamFull = fTeamFull + 1;
	self.fTeamMaxEnergy = 1000;
	self.fTeamEnergy	= 0;
	self.fTeamResources = 0;
	self.eSelection = spawn();
	
	self.items = IT_MECHWARRIOR;
	self.health = 100;
	self.armorvalue = 100;
	self.ammo_shells = 0;
	self.ammo_nails = 0;
	self.ammo_rockets = 0;
	self.ammo_cells = 0;
	self.weapon = IT_MECHWARRIOR;
	self.armortype = 0;
};

void()	mech_shot1 =	[1, mech_shot2	] {self.weaponframe=1; self.effects = self.effects | EF_MUZZLEFLASH; self.nextthink = time + 0.04;};
void()	mech_shot2 =	[2, mech_shot3	] {self.weaponframe=2; self.nextthink = time + 0.04;};
void()	mech_shot3 =	[3, mech_shot4	] {self.weaponframe=3; self.nextthink = time + 0.04;};
void()	mech_shot4 =	[4, mech_shot5	] {self.weaponframe=4; self.nextthink = time + 0.05;};
void()	mech_shot5 =	[5, mech_shot6	] {self.weaponframe=5; self.nextthink = time + 0.07;};
void()	mech_shot6 =	[6, mech_shot7	] {self.weaponframe=6; self.nextthink = time + 0.09;};
void()	mech_shot7 =	[4, mech_shot8	] {self.weaponframe=7; self.nextthink = time + 0.1;};
void()	mech_shot8 =	[5, mech_shot9	] {self.weaponframe=8; self.nextthink = time + 0.2;};
void()	mech_shot9 =	[6, player_run	] {self.weaponframe=9; self.nextthink = time + 0.3;};

float() crandom;
void() ApplyMultiDamage;
void() ClearMultiDamage;
void(entity hit, float damage) AddMultiDamage;
void(vector org, vector vel, float damage) SpawnBlood;

void(float damage, vector dir) Commando_TraceAttack =
{
	local	vector	vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
		SpawnBlood (org, vel*0.2, damage);
		AddMultiDamage (trace_ent, damage);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_EXPLOSION);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
};

void(float shotcount, vector dir, vector spread) Commando_FireBullets =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
			Commando_TraceAttack (4, direction);

		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
};

void() Commando_Mechwarrior_Fire =
{
	local vector dir;
	
	self.punchangle_x = -3 * random() - 1;
	mech_shot1();
	dir = aim (self, 100000);
	Commando_FireBullets (2, dir, '0.07 0.07 0');
	
	if(random() >= 0.5)
		sound (self, CHAN_WEAPON, "commando/ratling1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_WEAPON, "commando/ratling2.wav", 1, ATTN_NORM);
	
	self.attack_finished = time + 0.12;
};