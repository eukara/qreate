/*  Copyright (C) 2011-2014 OldTimes Software  */

/*
MINE:
	This is where players get standard resources from in Commando.
	You can mine things by manually or automated mining procedures.
*/

void() BecomeExplosion;
void(string gibname, float dm) ThrowGib;

void() object_mine =
{
	if(!self.health)			// If no health was set, make default 2000
		self.health = 2000;
	if(!self.model)				// Ditto for the model
		self.model = "progs/commine.mdl";
	
	precache_model(self.model);
	setmodel(self, self.model);
	self.solid = SOLID_BBOX;
};

void() qreate_commando_explode =
{
	ThrowGib("progs/debris.mdl", 50);
	ThrowGib("progs/debris.mdl", 50);
	ThrowGib("progs/debris.mdl", 50);
	ThrowGib("progs/debris.mdl", 50);
	ThrowGib("progs/debris.mdl", 50);
	ThrowGib("progs/debris.mdl", 50);
	
	if(self.style == 1)
	sound (self, CHAN_WEAPON, "commando/carexplo2.wav", 1, ATTN_NORM);
	
	BecomeExplosion ();
};

void() qreate_commando_car_die =
{
	local entity eTemp;
	local entity eWreck;
	
	eTemp = spawn();
	eTemp.owner = self;
	eTemp.origin = self.origin;
	setorigin(eTemp, self.origin);
	eTemp.style = 0;
	eTemp.think = qreate_commando_explode;
	eTemp.nextthink = time;
	
	sound (self, CHAN_WEAPON, "commando/carexplo1.wav", 1, ATTN_NORM);

	eWreck = spawn ();
	eWreck.owner = self;
	eWreck.movetype = MOVETYPE_BOUNCE;
	eWreck.solid = SOLID_BBOX;
	eWreck.classname = "grenade";
	eWreck.velocity_z = 400;
	eWreck.avelocity = '300 300 300';
	
// set missile duration
	eWreck.nextthink = time + 1;
	eWreck.style = 1;
	eWreck.think = qreate_commando_explode;

	setmodel (eWreck, "progs/lpcar1w.mdl");
	setsize (eWreck, '0 0 0', '0 0 0');		
	setorigin (eWreck, self.origin);
	
	remove(self);
};

void() qreate_commando_car =
{
	if(!self.health)			// If no health was set, make default 2000
		self.health = 1;
	if(!self.model)				// Ditto for the model
		self.model = "progs/lpcar1.mdl";
	
	precache_model(self.model);
	setmodel(self, self.model);
	self.solid = SOLID_BBOX;
	self.takedamage = DAMAGE_AIM;
	self.th_die = qreate_commando_car_die;
	setorigin(self, self.origin + '0 0 -10');
};

void() qreate_breakwall_die =
{
	local entity eTemp;
	
	eTemp = spawn();
	eTemp.owner = self;
	eTemp.origin = self.origin;
	setorigin(eTemp, self.origin);
	eTemp.think = qreate_commando_explode;
	eTemp.nextthink = time;
	remove(self);
};

void() qreate_breakwall =
{
	if(!self.health)
		self.health = 1;
	
	precache_model(self.model);
	setmodel(self, self.model);
	self.solid = SOLID_BBOX;
	self.takedamage = DAMAGE_AIM;
	self.th_die = qreate_breakwall_die;
};

void() team1_start = {};
void() team2_start = {};
void() team3_start = {};
void() team4_start = {};