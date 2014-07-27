// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

void(entity trent) qreate_tool_denied =
{

	if(self.qmsg > time)
		return;

	if(trent == world)
		return;

	self.qmsg = time + 2;
	sprint(self, "This does not belong to you.\n");

};
void(float mode, float reverse) qreate_tool_rotate =
{
	local entity new;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);

	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}
	
	if(trace_ent != world)
	{
		if(mode == 0)
		{
			if(reverse == 0)
			trace_ent.angles_x = trace_ent.angles_x + 1;
			else
			trace_ent.angles_x = trace_ent.angles_x - 1;
		}
		else if(mode == 1)
		{
			if(reverse == 0)
			trace_ent.angles_y = trace_ent.angles_y + 1;
			else
			trace_ent.angles_y = trace_ent.angles_y - 1;
		}
		else if(mode == 2)
		{
			if(reverse == 0)
			trace_ent.angles_z = trace_ent.angles_z + 1;
			else
			trace_ent.angles_z = trace_ent.angles_z - 1;
		}
	}

};

void(float mode, float reverse) qreate_tool_move =
{
	local entity new;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);
	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}
	if(trace_ent != world)
	{
		if(mode == 0)
		{
			if(reverse == 0)
			trace_ent.origin_x = trace_ent.origin_x + 1;
			else
			trace_ent.origin_x = trace_ent.origin_x - 1;
		}
		else if(mode == 1)
		{
			if(reverse == 0)
			trace_ent.origin_y = trace_ent.origin_y + 1;
			else
			trace_ent.origin_y = trace_ent.origin_y - 1;
		}
		else if(mode == 2)
		{
			if(reverse == 0)
			trace_ent.origin_z = trace_ent.origin_z + 1;
			else
			trace_ent.origin_z = trace_ent.origin_z - 1;
		}
		setorigin(trace_ent, trace_ent.origin);
	
	}

};

void() qreate_tool_remove =
{
	local entity new;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);
	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}
	if(trace_ent != world)
	{
		if(trace_ent.classname == "player")
			return;
		else if(trace_ent.classname == "monster_boss" || trace_ent.classname == "monster_oldone")
			self.qreate_bosscnt = 0;
			
		remove(trace_ent);
		sound (self, CHAN_AUTO, "effects/remove.wav", 1, ATTN_NORM);
	}
};

void() qreate_tool_skin =
{
	local entity new;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);
	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}

	if(trace_ent != world)
	{
		if(trace_ent.skin == 12)
		trace_ent.skin = 0;
		else
		trace_ent.skin = trace_ent.skin + 1;
		
		sound (self, CHAN_AUTO, "effects/switch01.wav", 1, ATTN_NORM);
		self.attack_finished = time + 0.4;
	}
};

void() qreate_tool_light =
{
	local entity new;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);
	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}

	if(trace_ent != world)
	{
		if(trace_ent.effects == 2)
		trace_ent.effects = 0;
		else if(trace_ent.effects == 0)
		trace_ent.effects = 1;
		else if(trace_ent.effects == 1)
		trace_ent.effects = 4;
		else if(trace_ent.effects == 4)
		trace_ent.effects = 8;
		else if(trace_ent.effects == 8)
		trace_ent.effects = 2;

		sound (self, CHAN_AUTO, "effects/switch01.wav", 1, ATTN_NORM);
		self.attack_finished = time + 0.4;
	}
};

void(float reverse) qreate_tool_frame =
{
	local entity new;
	local string framep;
	local vector dir;

	local	vector	src;
	string	trackp;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);
	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}
	if(trace_ent != world)
	{
		if(reverse == 0)
		trace_ent.frame = trace_ent.frame + 1;
		else
		trace_ent.frame = trace_ent.frame - 1;
		
		framep = ftos(trace_ent.frame);
		sprint(self, "[d] model frame: ");
		sprint(self, framep);
		sprint(self, "\n");
		sound (self, CHAN_AUTO, "effects/freamc.wav", 1, ATTN_NORM);
		self.attack_finished = time + 0.2;
	}
};

void() qreate_tool_camera =
{

 if(self.cammode == 0)
 {
	local	vector	src;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);

	if(trace_ent != world)
	{
		self.fixangle = TRUE;
		self.view_oldangles = self.angles;
		self.cam = trace_ent;	// Experimental.
		msg_entity = self;
  		WriteByte (MSG_ONE, SVC_SETVIEWPORT);
  		WriteEntity( MSG_ONE, trace_ent);
 		WriteByte (MSG_ONE, SVC_SETVIEWANGLES);
 		WriteAngle( MSG_ONE, trace_ent.angles_x); 
 		WriteAngle( MSG_ONE, trace_ent.angles_y);
 		WriteAngle( MSG_ONE, trace_ent.angles_z);
		self.weaponmodel = "";
		self.cammode = 1;
		self.attack_finished = time + 0.7;
	}
 }
 else if(self.cammode == 1)
 {
 	msg_entity = self;
  	WriteByte (MSG_ONE, SVC_SETVIEWPORT);
  	WriteEntity( MSG_ONE, self);
 	WriteByte (MSG_ONE, SVC_SETVIEWANGLES);
 	WriteAngle( MSG_ONE, 0); 
 	WriteAngle( MSG_ONE, self.view_oldangles_y);
 	WriteAngle( MSG_ONE, 0);

	W_SetCurrentAmmo();
	self.cammode = 0;
	self.attack_finished = time + 0.7;
 }
  
};

void() BecomeExplosion;
void(string modelpath, float pressure) ThrowGib;

void() qreate_break_explode =
{
	self.takedamage = DAMAGE_NO;
	sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);
	particle (self.origin, '0 0 0', 75, 255);

	self.origin_z = self.origin_z + 32;
	BecomeExplosion ();
};

void() qreate_break_gibblet =
{
	sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
	ThrowGib ("progs/gib1.mdl", -50);
	ThrowGib ("progs/gib2.mdl", -55);
	ThrowGib ("progs/gib3.mdl", -49);
	ThrowGib ("progs/gib1.mdl", -50);
	ThrowGib ("progs/gib2.mdl", -55);
	remove(self);
};

void()	qreate_dance1 =	[1, qreate_dance2	] {};
void()	qreate_dance2 =	[2, qreate_dance3	] {};
void()	qreate_dance3 =	[3, qreate_dance4	] {};
void()	qreate_dance4 =	[4, qreate_dance5	] {};
void()	qreate_dance5 =	[5, qreate_dance6	] {};
void()	qreate_dance6 =	[6, qreate_dance7	] {};
void()	qreate_dance7 =	[7, qreate_dance8	] {};
void()	qreate_dance8 =	[8, qreate_dance9	] {};
void()	qreate_dance9 =	[9, qreate_dance10	] {};
void()	qreate_dance10 =	[10, qreate_dance11	] {};
void()	qreate_dance11 =	[11, qreate_dance12	] {};
void()	qreate_dance12 =	[12, qreate_dance13	] {};
void()	qreate_dance13 =	[13, qreate_dance14	] {};
void()	qreate_dance14 =	[14, qreate_dance15	] {};
void()	qreate_dance15 =	[15, qreate_dance16	] {};
void()	qreate_dance16 =	[16, qreate_dance17	] {};
void()	qreate_dance17 =	[17, qreate_dance18	] {};
void()	qreate_dance18 =	[18, qreate_dance19	] {};
void()	qreate_dance19 =	[19, qreate_dance20	] {};
void()	qreate_dance20 =	[20, qreate_dance21	] {};
void()	qreate_dance21 =	[21, qreate_dance22	] {};
void()	qreate_dance22 =	[22, qreate_dance23	] {};
void()	qreate_dance23 =	[23, qreate_dance24	] {};
void()	qreate_dance24 =	[24, qreate_dance25	] {};
void()	qreate_dance25 =	[25, qreate_dance26	] {};
void()	qreate_dance26 =	[26, qreate_dance27	] {};
void()	qreate_dance27 =	[27, qreate_dance28	] {};
void()	qreate_dance28 =	[28, qreate_dance29	] {};
void()	qreate_dance29 =	[29, qreate_dance1	] {};

void() qreate_dance =
{
	sound (self, CHAN_VOICE, "arcade/mntrain.wav", 1, ATTN_NORM);
	ambientsound (self.origin, "arcade/mntrain.wav", 1, ATTN_NORM);
	setmodel(self,"progs/dance.mdl");
	self.takedamage = DAMAGE_AIM;
	self.health = 1;
	self.th_die = qreate_break_gibblet;

	qreate_dance1();
};

void() qreate_tool_quakebreak =
{
	local	vector	src;
	local	float	pmod;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*1024, FALSE, self);


	if (trace_ent.spawner != self)
	{
		qreate_tool_denied(trace_ent);
		return;
	}
	if(trace_ent != world)
	{
		if(trace_ent.model == "progs/player.mdl")
			pmod = 1;
		else
			pmod = 0;

		if(trace_ent.qmode == 3)
		{
			centerprint(self, "QB: NONE\n");
			trace_ent.takedamage = DAMAGE_NO;
			trace_ent.qmode = 0;
		}
		else if(trace_ent.qmode == 1)
		{
			centerprint(self, "QB: GIBBING\n");
			trace_ent.health = 1;
			trace_ent.th_die = qreate_break_gibblet;
			trace_ent.takedamage = DAMAGE_AIM;
			
			if(pmod)
				trace_ent.qmode = 2;
			else
				trace_ent.qmode = 3;
		}
		else if(trace_ent.qmode == 2 && pmod == 1)
		{	
			centerprint(self, "QB: PLEASE NO\n");
			trace_ent.health = 1;
			trace_ent.th_die = qreate_dance;
			trace_ent.takedamage = DAMAGE_AIM;
			trace_ent.qmode = 3;
		}
		else
		{	
			centerprint(self, "QB: EXPLODE\n");
			trace_ent.health = 1;
			trace_ent.th_die = qreate_break_explode;
			trace_ent.takedamage = DAMAGE_AIM;
			trace_ent.qmode = 1;
		}

		self.attack_finished = time + 0.2;
	}
};

void() qreate_printtselected =
{
	local string entname;

		if(self.tselected == 0)
			entname = "[t] 0 - remove tool\n";
		else if(self.tselected == 1)
			entname = "[t] 1 - rotate x axis\n";
		else if(self.tselected == 2)
			entname = "[t] 2 - rotate y axis\n";
		else if(self.tselected == 3)
			entname = "[t] 3 - rotate z axis\n";
		else if(self.tselected == 4)
			entname = "[t] 4 - move x\n";
		else if(self.tselected == 5)
			entname = "[t] 5 - move y\n";
		else if(self.tselected == 6)
			entname = "[t] 6 - move z\n";
		else if(self.tselected == 7)
			entname = "[t] 7 - change skin\n";
		else if(self.tselected == 8)
			entname = "[t] 8 - change frame\n";
		else if(self.tselected == 9)
			entname = "[t] 9 - change effect\n";
		else if(self.tselected == 10)
			entname = "[t] 10 - quake breaker\n";
		else if(self.tselected == 11)
			entname = "[t] 11 - swap viewpoint\n";
		
	centerprint (self, entname);
};

void() qreate_change_toolfw =
{
	self.tselected = self.tselected + 1;

	if(self.tselected > 11)
	self.tselected = 0;

 qreate_printtselected();
};

void() qreate_change_toolbw =
{
	self.tselected = self.tselected - 1;

	if(self.tselected < 0)
	self.tselected = 11;

 qreate_printtselected();
};

void() qreate_togglereverse =
{
	if(self.reversem)
	{
		self.reversem = 0;
		centerprint (self, "reverse off\n");
	}
	else
	{
		self.reversem = 1;
		centerprint (self, "reverse on\n");
	}
		
};
