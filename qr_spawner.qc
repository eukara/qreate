// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

// FWILL SPAWN CODE
// Written by eukos

void(void() monstername) qreate_spawn =
 {
	local entity new;

	local	vector	src;

	if(monstername == boss_awake || monstername == monster_oldone)
	{
		if(self.qreate_bosscnt == 1)
			return;
		else
			self.qreate_bosscnt = 1;
	}

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);

	new = spawn();
	new.origin = trace_endpos + '0 0 24';
	new.angles_y = self.angles_y;
	new.qreate_modify = FALSE;
		
	new.think = monstername;
	new.spawner = self;
	new.nextthink = time;
	sound (self, CHAN_AUTO, "effects/splash.wav", 1, ATTN_NORM);

};

void() qreate_prop_wall =
{
    self.solid = SOLID_BSP;
    self.movetype = MOVETYPE_PUSH;
	setmodel (self, "progs/wall1.bsp");
	self.angles = '0 0 0';
	setorigin(self, self.origin + '0 0 -24');
};

void() qreate_prop_wall2 =
{
    self.solid = SOLID_BSP;
   	self.movetype = MOVETYPE_PUSH;
	setmodel (self, "progs/wall2.bsp");
	self.angles = '0 0 0';
	setorigin(self, self.origin + '0 0 -24');
};

void() qreate_prop_floor =
{
    self.solid = SOLID_BSP;
    self.movetype = MOVETYPE_PUSH;
	setmodel (self, "progs/floor.bsp");
	self.angles = '0 0 0';
	setorigin(self, self.origin + '0 0 -24');
};

void() qreate_prop_player =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/player.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};

void() prop_torch =
{
	self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/flame.mdl");
	setsize (self, '-5 -5 -5', '5 5 5');
};

void() qreate_prop_dragon =
{
	self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/dragon.mdl");
	self.origin = self.origin + '0 0 35';
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};

void() qreate_prop_army =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/soldier.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_boss =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/boss.mdl");
	setsize (self, '-128 -128 -24', '128 128 256');
};
void() qreate_prop_demon =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/demon.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};
void() qreate_prop_dog =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/dog.mdl");
	setsize (self, '-32 -32 -24', '32 32 40');
};
void() qreate_prop_enforcer =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/enforcer.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_fish =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/fish.mdl");
	setsize (self, '-16 -16 -24', '16 16 24');
};
void() qreate_prop_hknight =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/hknight.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_knight =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/knight.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_ogre =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/ogre.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};
void() qreate_prop_oldone =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/oldone.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};
void() qreate_prop_shalrath =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/shalrath.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};
void() qreate_prop_shambler =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/shambler.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
};
void() qreate_prop_tarbaby =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/tarbaby.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_wizard =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/wizard.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_prop_zombie =
{
    self.solid = SOLID_BBOX;
    self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/zombie.mdl");
	setsize (self, '-16 -16 -24', '16 16 40');
};
void() qreate_selectspawn =
{
	if (self.selected == 0)
		qreate_spawn (monster_army);
	if (self.selected == 1)
		qreate_spawn (qreate_prop_army);
	else if (self.selected == 2)
		qreate_spawn (boss_awake);
	else if (self.selected == 3)
		qreate_spawn (qreate_prop_boss);
	else if (self.selected == 4)
		qreate_spawn (monster_demon1);
	else if (self.selected == 5)
		qreate_spawn (qreate_prop_demon);
	else if (self.selected == 6)
		qreate_spawn (monster_dog);
	else if (self.selected == 7)
		qreate_spawn (qreate_prop_dog);
	else if (self.selected == 8)
		qreate_spawn (monster_enforcer);
	else if (self.selected == 9)
		qreate_spawn (qreate_prop_enforcer);
	else if (self.selected == 10)
		qreate_spawn (monster_fish);
	else if (self.selected == 11)
		qreate_spawn (qreate_prop_fish);
	else if (self.selected == 12)
		qreate_spawn (monster_hell_knight);
	else if (self.selected == 13)
		qreate_spawn (qreate_prop_hknight);
	else if (self.selected == 14)
		qreate_spawn (monster_knight);
	else if (self.selected == 15)
		qreate_spawn (qreate_prop_knight);
	else if (self.selected == 16)
		qreate_spawn (monster_ogre);
	else if (self.selected == 17)
		qreate_spawn (qreate_prop_ogre);
	else if (self.selected == 18)
		qreate_spawn (qreate_prop_dragon);
	else if (self.selected == 19)
		qreate_spawn (monster_oldone);
	else if (self.selected == 20)
		qreate_spawn (qreate_prop_oldone);
	else if (self.selected == 21)
		qreate_spawn (monster_shalrath);
	else if (self.selected == 22)
		qreate_spawn (qreate_prop_shalrath);
	else if (self.selected == 23)
		qreate_spawn (monster_shambler);
	else if (self.selected == 24)
		qreate_spawn (qreate_prop_shambler);
	else if (self.selected == 25)
		qreate_spawn (monster_tarbaby);
	else if (self.selected == 26)
		qreate_spawn (qreate_prop_tarbaby);
	else if (self.selected == 27)
		qreate_spawn (monster_wizard);
	else if (self.selected == 28)
		qreate_spawn (qreate_prop_wizard);
	else if (self.selected == 29)
		qreate_spawn (monster_zombie);
	else if (self.selected == 30)
		qreate_spawn (qreate_prop_zombie);
		
	else if (self.selected == 31)
		qreate_spawn (item_armor1);
	else if (self.selected == 32)
		qreate_spawn (item_armor2);
	else if (self.selected == 33)
		qreate_spawn (item_armorInv);
	else if (self.selected == 34)
		qreate_spawn (item_artifact_envirosuit);
	else if (self.selected == 35)
		qreate_spawn (item_artifact_invisibility);
	else if (self.selected == 36)
		qreate_spawn (item_artifact_invulnerability);
	else if (self.selected == 37)
		qreate_spawn (item_artifact_super_damage);
	else if (self.selected == 38)
		qreate_spawn (item_cells);
	else if (self.selected == 39)
		qreate_spawn (item_health);
	else if (self.selected == 40)
		qreate_spawn (item_key1);
	else if (self.selected == 41)
		qreate_spawn (item_key2);
	else if (self.selected == 42)
		qreate_spawn (item_rockets);
	else if (self.selected == 43)
		qreate_spawn (item_shells);
	else if (self.selected == 44)
		qreate_spawn (prop_torch);
	else if (self.selected == 45)
		qreate_spawn (item_spikes);

	else if (self.selected == 46)
		qreate_spawn (weapon_grenadelauncher);
	else if (self.selected == 47)
		qreate_spawn (weapon_lightning);
	else if (self.selected == 48)
		qreate_spawn (weapon_nailgun);
	else if (self.selected == 49)
		qreate_spawn (weapon_rocketlauncher);
	else if (self.selected == 50)
		qreate_spawn (weapon_supernailgun);
	else if (self.selected == 51)
		qreate_spawn (weapon_supershotgun);
	else if (self.selected == 52)
		qreate_spawn (qreate_prop_wall);
	else if (self.selected == 53)
		qreate_spawn (qreate_prop_wall2);
	else if (self.selected == 54)
		qreate_spawn (qreate_prop_floor);
	else if (self.selected == 55)
		qreate_spawn (qreate_prop_player);
};

void() qreate_printselected =
{
	local string entname;

	if (self.selected == 0)
		entname = "[e] - monster_army";
	if (self.selected == 1)
		entname = "[e] - prop_army";
	else if (self.selected == 2)
		entname = "[e] - monster_boss";
	else if (self.selected == 3)
		entname = "[e] - prop_boss";
	else if (self.selected == 4)
		entname = "[e] - monster_demon1";
	else if (self.selected == 5)
		entname = "[e] - prop_demon";
	else if (self.selected == 6)
		entname = "[e] - monster_dog";
	else if (self.selected == 7)
		entname = "[e] - prop_dog";
	else if (self.selected == 8)
		entname = "[e] - monster_enforcer";
	else if (self.selected == 9)
		entname = "[e] - prop_enforcer";
	else if (self.selected == 10)
		entname = "[e] - monster_fish";
	else if (self.selected == 11)
		entname = "[e] - prop_fish";
	else if (self.selected == 12)
		entname = "[e] - monster_hell_knight";
	else if (self.selected == 13)
		entname = "[e] - prop_hknight";
	else if (self.selected == 14)
		entname = "[e] - monster_knight";
	else if (self.selected == 15)
		entname = "[e] - prop_knight";
	else if (self.selected == 16)
		entname = "[e] - monster_ogre";
	else if (self.selected == 17)
		entname = "[e] - prop_ogre";
	else if (self.selected == 18)
		entname = "[e] - monster_dragon";
	else if (self.selected == 19)
		entname = "[e] - monster_oldone";
	else if (self.selected == 20)
		entname = "[e] - prop_oldone";
	else if (self.selected == 21)
		entname = "[e] - monster_shalrath";
	else if (self.selected == 22)
		entname = "[e] - prop_shalrath";
	else if (self.selected == 23)
		entname = "[e] - monster_shambler";
	else if (self.selected == 24)
		entname = "[e] - prop_shambler";
	else if (self.selected == 25)
		entname = "[e] - monster_tarbaby";
	else if (self.selected == 26)
		entname = "[e] - prop_tarbaby";
	else if (self.selected == 27)
		entname = "[e] - monster_wizard";
	else if (self.selected == 28)
		entname = "[e] - prop_wizard";
	else if (self.selected == 29)
		entname = "[e] - monster_zombie";
	else if (self.selected == 30)
		entname = "[e] - prop_zombie";
		
	else if (self.selected == 31)
		entname = "[e] - item_armor1";
	else if (self.selected == 32)
		entname = "[e] - item_armor2";
	else if (self.selected == 33)
		entname = "[e] - item_armorInv";
	else if (self.selected == 34)
		entname = "[e] - item_artifact_envirosuit";
	else if (self.selected == 35)
		entname = "[e] - item_artifact_invisibility";
	else if (self.selected == 36)
		entname = "[e] - item_artifact_invulnerability";
	else if (self.selected == 37)
		entname = "[e] - item_artifact_super_damage";
	else if (self.selected == 38)
		entname = "[e] - item_cells";
	else if (self.selected == 39)
		entname = "[e] - item_health";
	else if (self.selected == 40)
		entname = "[e] - item_key1";
	else if (self.selected == 41)
		entname = "[e] - item_key2";
	else if (self.selected == 42)
		entname = "[e] - item_rockets";
	else if (self.selected == 43)
		entname = "[e] - item_shells";
	else if (self.selected == 44)
		entname = "[e] - light_torch_small_walltorch";
	else if (self.selected == 45)
		entname = "[e] - item_spikes";

	else if (self.selected == 46)
		entname = "[e] - weapon_grenadelauncher";
	else if (self.selected == 47)
		entname = "[e] - weapon_lightning";
	else if (self.selected == 48)
		entname = "[e] - weapon_nailgun";
	else if (self.selected == 49)
		entname = "[e] - weapon_rocketlauncher";
	else if (self.selected == 50)
		entname = "[e] - weapon_supernailgun";
	else if (self.selected == 51)
		entname = "[e] - weapon_supershotgun";
		
	else if (self.selected == 52)
		entname = "[e] - prop_wall";
	else if (self.selected == 53)
		entname = "[e] - prop_wall2";
	else if (self.selected == 54)
		entname = "[e] - prop_floor";
	else if (self.selected == 55)
		entname = "[e] - prop_player";
	centerprint (self, entname);
};

void() qreate_change_entityfw =
{
	self.selected = self.selected + 1;

	if(self.selected > 55)
	self.selected = 0;

 qreate_printselected();
};

void() qreate_change_entitybw =
{
	self.selected = self.selected - 1;

	if(self.selected < 0)
	self.selected = 55;

 qreate_printselected();
};

void() qreate_ambient =
{
	float iAttenuation;
	precache_sound (self.noise);

	if(!self.style)		// everywhere
		iAttenuation = ATTN_NONE;
	else if(self.style == 1)	// small
		iAttenuation = ATTN_IDLE;
	else if(self.style == 2)	// medium
		iAttenuation = ATTN_STATIC;
	else if(self.style == 3) 	// large
		iAttenuation = ATTN_NORM;
	else
		iAttenuation = ATTN_NORM;

	ambientsound (self.origin, self.noise, self.volume, iAttenuation);
};

void() qreate_sound_use =
{
	float iAttenuation;

	if(!self.style)		// everywhere
		iAttenuation = ATTN_NONE;
	else if(self.style == 1)	// small
		iAttenuation = ATTN_IDLE;
	else if(self.style == 2)	// medium
		iAttenuation = ATTN_STATIC;
	else if(self.style == 3) 	// large
		iAttenuation = ATTN_NORM;
	else
		iAttenuation = ATTN_NORM;

	sound (self, CHAN_AUTO, self.noise, self.volume, iAttenuation);
};

void() qreate_sound =
{
	precache_sound (self.noise);
	self.use = qreate_sound_use;
}; 