// QREATE - WIRE FRAMEWORK
// Written by eukara
//
// All objects, gates and so on operate at a frequency of 60Hz.
// With every 0.0166666666 second they will be able to perform an operation.
//
// This framework allows people to go nuts in Qreate and build logical contraptions
// as well as basic computers that will allows them to create everything their heart
// desires. From simple things such as a lamp in your house with a lightswitch to
// explosive traps, doors with keycodes and many more.

void() qreate_wire_precache =
{
	precache_model("progs/wgat.mdl");
	precache_model("progs/wbtn.mdl");
	precache_model("progs/wspkr.mdl");
	precache_sound("wire/blip1.wav");

};

void() qreate_wire_helper =
{
	local	vector	vSrc;

	if(self.rp_menutime > time)
		return;
		
	self.rp_menutime = time + 0.3;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);
	if(trace_ent != world)
	{
		if(!(trace_ent.flags & FL_WIRE))
			return;

		centerprint(self,trace_ent.classname);

	}
};
// WIRE TOOL Primary
//
// This is the 'linker', it connects two wire objects together (first the object that requires an input, e.g
// an explosive)
void() qreate_tool_wire =
{
	local	vector	vSrc;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);


	if (qreate_tool_denied(trace_ent) == FALSE)
		return;

	if(trace_ent != world)
	{
		if(!(trace_ent.flags & FL_WIRE))
		{
			centerprint(self, "Not a compatible wire object!");
			self.attack_finished = time + 0.3;
			return;
		}

		if(!(self.qreate_wire)) // In which stage are we (0 = Input, 1 = Output)
		{
		  	self.qreate_wireent = trace_ent;
			centerprint(self, "Now select an output source");
			self.qreate_wire = 1;
		}
		else
		{
			if(trace_ent == self.qreate_wireent)
			{
				centerprint(self, "You cannot wire an entity to itself!\nWire Link Cancelled");
				self.qreate_wire = 0;
				self.attack_finished = time + 0.3;
				self.rp_menutime = time + 0.6;
				return;
			}

			if(self.qreate_wireent.mode == 1)
			{
				self.qreate_wireent.qreate_wirein2 = trace_ent;
				centerprint(self, trace_ent.classname, " linked to input 2");
			}
			else
			{
				self.qreate_wireent.qreate_wirein1 = trace_ent;
				centerprint(self, trace_ent.classname, " linked to input 1");
			}

			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
			WriteEntity (MSG_BROADCAST, self.qreate_wireent);
			WriteCoord (MSG_BROADCAST, self.qreate_wireent.origin_x);
			WriteCoord (MSG_BROADCAST, self.qreate_wireent.origin_y);
			WriteCoord (MSG_BROADCAST, self.qreate_wireent.origin_z);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_x);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_y);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_z);
			self.qreate_wire = 0;

		}	
	}
	self.attack_finished = time + 0.3;
	self.rp_menutime = time + 1;
};

// WIRE TOOL Secondary
//
// This is the mode switcher, essential for selecting which type of input/output you want to achieve.
// For example, if you want to link Input 2 to an Output, you have to change a gates' mode first.
void() qreate_tool_wire_mode =
{
	local	vector	vSrc;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);


	if (qreate_tool_denied(trace_ent) == FALSE)
		return;

	if(trace_ent != world)
	{
		if(!(trace_ent.flags & FL_WIRE))
		{
			centerprint(self, "Not a compatible wire object!");
			return;
		}

		if(!(trace_ent.mode >= trace_ent.qreate_wire_maxmode))
			trace_ent.mode = trace_ent.mode + 1;
		else
			trace_ent.mode = 0;

		string sTmp = ftos(trace_ent.mode);
		centerprint(self, "mode changed to ", sTmp);
		self.rp_menutime = time + 1;

	}
	self.attack_finished = time + 0.3;
};

// Simple, silly debugging tool for wire objects
void() qreate_tool_wire_debug =
{
	local	vector	vSrc;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);


	if (qreate_tool_denied(trace_ent) == FALSE)
		return;

	if(trace_ent != world)
	{
		if(!(trace_ent.flags & FL_WIRE))
		{
			centerprint(self, "Not a compatible wire object!");
			return;
		}

		if(trace_ent.qreate_wirein1 && trace_ent.qreate_wirein1.qreate_wireout == 1)
		{
			sprint(self,"\nInput 1: 1");
			local entity eTemp;
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
			WriteEntity (MSG_BROADCAST, eTemp);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_x);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_y);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_z);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein1.origin_x);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein1.origin_y);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein1.origin_z);
		}
		else if(trace_ent.qreate_wirein1 && trace_ent.qreate_wirein1.qreate_wireout == 0)
			sprint(self,"\nInput 1: 0");

		if(trace_ent.qreate_wirein2 && trace_ent.qreate_wirein2.qreate_wireout == 1)
		{
			sprint(self,"\nInput 2: 1");
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
			WriteEntity (MSG_BROADCAST, trace_ent);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_x);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_y);
			WriteCoord (MSG_BROADCAST, trace_ent.origin_z);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein2.origin_x);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein2.origin_y);
			WriteCoord (MSG_BROADCAST, trace_ent.qreate_wirein2.origin_z);
		}
		else if(trace_ent.qreate_wirein2 && trace_ent.qreate_wirein2.qreate_wireout == 0)
			sprint(self,"\nInput 2: 0");

		if(trace_ent.qreate_wireout == 1)
			sprint(self,"\nOutput: 1");
		else if(trace_ent.qreate_wireout == 0)
			sprint(self,"\nOutput: 0");
		//eprint(trace_ent);
		//

	}
	self.attack_finished = time + 1;
};

// WIRE AND-GATE
//
// First of the logical gates. If the two inputs return 1, then the output will be one.
void() qreate_wire_gate_and_think =
{
	if(self.qreate_wirein1 && self.qreate_wirein2)
	{
		if(self.qreate_wirein1.qreate_wireout && self.qreate_wirein2.qreate_wireout)
			self.qreate_wireout = 1;
		else
			self.qreate_wireout = 0;
	}

	self.nextthink = self.ltime + 1;
};

void() qreate_wire_gate_and =
{
	local	vector	vSrc;
	local 	vector 	vNorm;
	entity 	eGate;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	eGate = spawn();
	eGate.classname = "Wire: And-Gate";

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wgat.mdl");
	eGate.skin = 0;
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.flags = FL_WIRE + FL_WIREGATE;
	eGate.qreate_wire_maxmode = 1;
	eGate.spawner = self;

	eGate.think = qreate_wire_gate_and_think;
	eGate.nextthink = eGate.ltime + 1;
	self.attack_finished = time + 0.3;
};

// WIRE OR-GATE
//
// This logical gate checks if either one of the two inputs return 1. If one of them does, it will output 1 as well.
void() qreate_wire_gate_or_think =
{	
	if(self.qreate_wirein1 && self.qreate_wirein2)
	{
		if(self.qreate_wirein1.qreate_wireout || self.qreate_wirein2.qreate_wireout)
			self.qreate_wireout = 1;
		else
			self.qreate_wireout = 0;
	}

	self.nextthink = self.ltime + 1;
};

void() qreate_wire_gate_or =
{
	local	vector	vSrc;
	local vector vNorm;
	entity 	eGate;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	eGate = spawn();
	eGate.classname = "Wire: Or-Gate";
	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wgat.mdl");
	eGate.skin = 1;
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');	
	eGate.flags = FL_WIRE + FL_WIREGATE;
	eGate.qreate_wire_maxmode = 1;
	eGate.spawner = self;

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;


	eGate.think = qreate_wire_gate_or_think;
	eGate.nextthink = eGate.ltime + 1;
	self.attack_finished = time + 0.3;
	
};

// WIRE NOT-GATE
//
// This gate is essentially an inverter. If the input is 0, it will output 1 - if the input is 1, it will output 0.
void() qreate_wire_gate_not_think =
{	
	if(self.qreate_wirein1)
	{
		if(!(self.qreate_wirein1.qreate_wireout))
			self.qreate_wireout = 1;
		else
			self.qreate_wireout = 0;
	}
	else
		self.qreate_wireout = 0;

	self.nextthink = self.ltime + 1;

};

void() qreate_wire_gate_not =
{
	local	vector	vSrc;
	local vector vNorm;
	entity 	eGate;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	eGate = spawn();
	eGate.classname = "Wire: Not-Gate";

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wgat.mdl");
	eGate.skin = 2;
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');	
	eGate.flags = FL_WIRE;
	eGate.qreate_wire_maxmode = 0;
	eGate.spawner = self;

	eGate.think = qreate_wire_gate_not_think;
	eGate.nextthink = eGate.ltime + 1;
	self.attack_finished = time + 0.3;
	
};

// WIRE BINARY-VALUE
// A static value that either returns 0 or 1! Switch 'em with modes.
void() qreate_wire_binaryvalue_think =
{
	if(!(self.mode))
		self.qreate_wireout = 1;
	else
		self.qreate_wireout = 0;

	self.nextthink = self.ltime + 1;
};

void() qreate_wire_binaryvalue =
{
	local	vector	vSrc;
	local 	vector vNorm;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Binary Value";

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wgat.mdl");
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.think	= qreate_wire_binaryvalue_think;
	eGate.nextthink = eGate.ltime + 1;
	eGate.skin = 3;
	eGate.spawner = self;
	eGate.flags = FL_WIRE;
	eGate.qreate_wire_maxmode = 1;
	self.attack_finished = time + 0.3;
};


// OBJECTS
//
//

// WIRE BUTTON
// Just a pushable button that you can place, if it's placed and pushed it will return 1.
// Mode 2 makes the button return after 1 second.
void()	qreate_wire_button_up	=[	0,		SUB_Null	] {};
void()	qreate_wire_button_down	=[	2,		SUB_Null	] {};

void() qreate_wire_button_think =
{

	if(!(self.qreate_wireout))
	{
		self.qreate_wireout = 1;
		qreate_wire_button_down();
	}
	else
	{
		self.qreate_wireout = 0;
		qreate_wire_button_up();
	}
};

void() qreate_wire_button_use =
{
	if(self.attack_finished > time)
		return;

	if(other.classname != "player")
		return;

	if(!(self.qreate_wireout))
	{
		self.qreate_wireout = 1;
		qreate_wire_button_down();
		
	}
	else
	{
		self.qreate_wireout = 0;
		qreate_wire_button_up();
	}

	if(self.mode)
	{
		  self.think = qreate_wire_button_think;
		  self.nextthink = self.ltime + 1.0;
		  self.attack_finished = time + 2;
		  return;
	}


	self.attack_finished = time + 0.5;
};

void() qreate_wire_button =
{
	local	vector	vSrc;
	local 	vector 	vNorm;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Button";
	eGate.flags = FL_WIRE;

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wbtn.mdl");
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.touch = qreate_wire_button_use;
	eGate.spawner = self;
	eGate.qreate_wire_maxmode = 1;
	self.attack_finished = time + 0.3;
};

// WIRE DOOR
// If input is 1, it will open and return 1
// If input is 0, it will close and return 0
void() qreate_wire_door_think =
{
	if(self.qreate_wirein1 && self.qreate_wirein1.qreate_wireout)
	{	
		if(self.state != STATE_UP)
			setorigin(self, self.origin + '0 0 90');

		self.state = STATE_UP;
		self.qreate_wireout = 1;
		self.nextthink = self.ltime + 0.1;
		return;
	}
	
	if(self.state == STATE_UP)
	{	
		setorigin(self, self.origin - '0 0 90');
		self.state = STATE_DOWN;
	}
	self.qreate_wireout = 0;
	self.nextthink = self.ltime + 0.1;
};

void() qreate_wire_door =
{
	local	vector	vSrc;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Door";
	eGate.flags = FL_WIRE;
	eGate.solid = SOLID_BSP;
    	eGate.movetype = MOVETYPE_PUSH;
	setmodel (eGate, "progs/wall1.bsp");
	eGate.angles = '0 0 0';
	setorigin(eGate, trace_endpos);	
	eGate.think = qreate_wire_door_think;
	eGate.nextthink = eGate.ltime + 0.1;
	eGate.spawner = self;
	eGate.qreate_wire_maxmode = 2;
	self.attack_finished = time + 0.3;
};


// WIRE LAMP
// If input is 1, there will be light
// If input is 0, then it's gonna be dark
void() qreate_wire_lamp_think =
{
	if(self.qreate_wirein1 && self.qreate_wirein1.qreate_wireout)
	{	
		self.qreate_wireout = 1;
		self.effects = 8;
		self.nextthink = self.ltime + 0.1;
		return;
	}
	
	
	self.qreate_wireout = 0;
	self.effects = 0;
	self.nextthink = self.ltime + 0.1;
};

void() qreate_wire_lamp =
{
	local	vector	vSrc;
	local 	vector 	vNorm;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Lamp";
	eGate.flags = FL_WIRE;

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wspkr.mdl");
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.think = qreate_wire_lamp_think;
	eGate.nextthink = eGate.ltime + 0.1;
	eGate.spawner = self;
	eGate.qreate_wire_maxmode = 0;
	self.attack_finished = time + 0.3;
};


// WIRE EXPLOSIVE
// If the input is 1, it will blow your brains out
void() qreate_wire_explosive_think =
{
	if(self.qreate_wirein1)
	{
		if(self.qreate_wirein1.qreate_wireout)
		{
			// Explode
			self.takedamage = DAMAGE_NO;
			sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
			particle (self.origin, '0 0 0', 75, 255);
			T_RadiusDamage (self, self.owner, 50, world, "");
			//self.origin_z = self.origin_z + 32;
			BecomeExplosion ();
			return;
		}
	}

	self.nextthink = self.ltime + 1;
};

void() qreate_wire_explosive =
{
	local	vector	vSrc;
	local 	vector 	vNorm;
	entity 	eGate;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	eGate = spawn();
	eGate.classname = "Wire: Explosive";

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/grenade.mdl");
	eGate.skin = 0;
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.flags = FL_WIRE;
	eGate.qreate_wire_maxmode = 0;
	eGate.spawner = self;

	eGate.think = qreate_wire_explosive_think;
	eGate.nextthink = eGate.ltime + 1;
	self.attack_finished = time + 0.3;
};

// WIRE SPEAKER
// Plays a sound when input is 1
void() qreate_wire_speaker_think =
{
	if(self.qreate_wirein1 && self.qreate_wirein1.qreate_wireout)
	{	
		if(!(self.qreate_wireout))
			sound (self, CHAN_WEAPON, "wire/blip1.wav", 1, ATTN_NORM);

		self.qreate_wireout = 1;
		self.nextthink = self.ltime + 0.1;
		return;
	}
	
	self.qreate_wireout = 0;
	self.nextthink = self.ltime + 0.1;
};

void() qreate_wire_speaker =
{
	local	vector	vSrc;
	local 	vector 	vNorm;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Speaker";
	eGate.flags = FL_WIRE;

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wspkr.mdl");
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.think = qreate_wire_speaker_think;
	eGate.nextthink = eGate.ltime + 0.1;
	eGate.spawner = self;
	eGate.qreate_wire_maxmode = 0;
	self.attack_finished = time + 0.3;
};

// WIRE TIMER
// When input is 1, it counts a value down (which you can set with mode)
// Once the timer is done, it will output 1.
void() qreate_wire_timer_think;
void() qreate_wire_timer_use =
{
	self.qreate_wireout = 1;
	self.nextthink = self.ltime + 0.1;
	self.think = qreate_wire_timer_think;
};

void() qreate_wire_timer_think =
{
	if(self.qreate_wirein1 && self.qreate_wirein1.qreate_wireout)
	{	
		if(!(self.qreate_wireout))
		{
			self.think = qreate_wire_timer_use;
			self.nextthink = self.ltime + self.mode + 1;
			return;
		}

		self.nextthink = self.ltime + 0.1;
		return;
	}
	
	self.qreate_wireout = 0;
	self.nextthink = self.ltime + 0.1;
};

void() qreate_wire_timer =
{
	local	vector	vSrc;
	local 	vector 	vNorm;

	vSrc = self.origin + v_forward*10;
	vSrc_z = self.absmin_z + self.size_z * 0.7;
	traceline (vSrc, vSrc + v_forward*1024, FALSE, self);

	entity eGate;
	eGate = spawn();
	eGate.classname = "Wire: Timer";
	eGate.flags = FL_WIRE;

	vNorm = trace_plane_normal;
	eGate.angles = vectoangles(vNorm);
	eGate.angles_x = eGate.angles_x - 90;

	setorigin(eGate, trace_endpos);
	setmodel(eGate, "progs/wspkr.mdl");
	eGate.solid = SOLID_BBOX;
	eGate.movetype = MOVETYPE_PUSH;
	setsize(eGate, '-6 -6 -6', '6 6 6');
	eGate.think = qreate_wire_timer_think;
	eGate.nextthink = eGate.ltime + 0.1;
	eGate.spawner = self;
	eGate.qreate_wire_maxmode = 9;
	self.attack_finished = time + 0.3;
};

