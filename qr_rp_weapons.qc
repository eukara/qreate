// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY WEAPONS
// *******
//
// Feel free to edit these!

float(entity player) RP_SetCurrentAmmo =
{
	if (player.weapon == IT_KEYS)
	{
		player.currentammo = 0;
		player.weaponmodel = "";
		player.weaponframe = 0;
	}
	else
		return 0;
	
	return 1;
};

float() RP_WeaponAttack =
{

	if (self.weapon == IT_KEYS)
	{
		local	vector	source;

		makevectors (self.v_angle);
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward*124, FALSE, self);

		if (trace_ent.classname == "door")
		{
			if(trace_ent.rp_owner == self)
			{
				if(trace_ent.rp_locked)
				{
					centerprint(self, "Your door is now unlocked.");
					self.rp_menutime = time + 2;
					trace_ent.rp_locked = 0;
					sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
				}
				else
				{
					centerprint(self, "Your door is now locked.");
					self.rp_menutime = time + 2;
					trace_ent.rp_locked = 1;
					sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
				}
			}
			else
			{
				centerprint(self, "Knock. Knock.");
				self.rp_menutime = time + 2;
				sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
			}
		}
		else if (trace_ent.classname == "func_movewall")
		{
			if(trace_ent.owner.rp_owner == self)
			{
				if(trace_ent.owner.rp_locked)
				{
					centerprint(self, "Your door is now unlocked.");
					self.rp_menutime = time + 2;
					trace_ent.owner.rp_locked = 0;
					sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
				}
				else
				{
					centerprint(self, "Your door is now locked.");
					self.rp_menutime = time + 2;
					trace_ent.owner.rp_locked = 1;
					sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
				}
			}
			else
			{
				centerprint(self, "Knock. Knock.");
				self.rp_menutime = time + 2;
				sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
			}
		}

		
		self.attack_finished = time + 1;
	}
	else
		return 0;
	
	return 1;
};

float() RP_WeaponAttack_Secondary =
{
local entity oself;

	if (self.weapon == IT_KEYS)
	{
		local	vector	source;

		makevectors (self.v_angle);
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward*124, FALSE, self);

		if (trace_ent.classname == "door")
		{
			if(trace_ent.rp_locked == FALSE)
			{
				oself = self;
				self = trace_ent;
				self.use();
				self = oself;
				//trace_ent.use();		
			}
			else
			{
				centerprint(self, "Knock. Knock.");
				self.rp_menutime = time + 2;
				sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
			}
		}
		else if (trace_ent.classname == "func_movewall")
		{
			if(trace_ent.owner.rp_locked == FALSE)
			{
				oself = self;
				self = trace_ent.owner;
				self.use();
				self = oself;
			}
			else
			{
				centerprint(self, "Knock. Knock.");
				self.rp_menutime = time + 2;
				sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
			}
		}

		
		self.attack_finished = time + 1;
	}
	else
		return 0;
	
	return 1;
};
