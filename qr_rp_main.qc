// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

void() RP_Payday_Update =
{
	local entity pl;
	string pls;
	
	pl = findradius (self.origin, 10000);
    while(pl)
    {
		if(pl.classname == "player") 
        {
			pls = ftos(pl.rp_salary);
			pl.rp_money = pl.rp_money + pl.rp_salary;
			centerprint (pl, "Payday! You received $", pls, "!\n");
		}
        pl = pl.chain;
    }
	
	self.nextthink = time + 160;
};

void() RP_InitJobs =
{
	if(!(world.TITLE_JOB_CITIZEN))
		world.TITLE_JOB_CITIZEN = "Citizen";
	if(!(world.TITLE_JOB_POLICEFORCE))
		world.TITLE_JOB_POLICEFORCE = "Police Force";
	if(!(world.TITLE_JOB_MOBSTER))
		world.TITLE_JOB_MOBSTER = "Mobster";
	if(!(world.TITLE_JOB_GUNDEALER))
		world.TITLE_JOB_GUNDEALER = "Gun Dealer";
	if(!(world.TITLE_JOB_MEDIC))
		world.TITLE_JOB_MEDIC = "Medic";
	if(!(world.TITLE_JOB_MERCHANT))
		world.TITLE_JOB_MERCHANT = "Merchant";
	if(!(world.TITLE_JOB_MAYOR))
		world.TITLE_JOB_MAYOR = "Mayor";
};

void() RP_Main =
{
	local entity rp_pday;
	local entity rp_lspeaker;
	
	RP_SetPrecaches();
	RP_InitJobs();
	
	rp_pday = spawn();
	rp_pday.think = RP_Payday_Update;
	rp_pday.nextthink = time + 5;
	world.rp_payday = rp_pday;
	
	rp_lspeaker = spawn();
	rp_lockdown = FALSE;
	world.rp_lockdownspeaker = rp_lspeaker;
};

float(float value) RP_CheckMoney =
{
	if(self.rp_money >= value)
		return TRUE;
	else
		return FALSE;
};

float(float id, entity player) RP_CheckJob =
{
	if(player.rp_job == id)
		return TRUE;
	else
		return FALSE;
};

float(float id, entity player) RP_CheckInventory =
{
	if(player.items & id)
		return TRUE;
	else
		return FALSE;
};

void() RP_BuyDoor =
{
	local	vector	source;

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "door")
	{
		if(trace_ent.rp_owner == self)
		{
			centerprint(self, "You already own this door.");
			self.rp_menutime = time + 2;
		}
		else if (trace_ent.rp_owner == world)
		{
			if(!RP_CheckMoney(20))
			{
				centerprint(self, "You don't have enough money to buy this.");
				self.rp_menutime = time + 2;
				return;
			}
			
			centerprint(self, "You bought this door for $20!");
			stuffcmd(self, "play roleplay/cash.wav\n");
			
			self.rp_menutime = time + 2;
			self.rp_money = self.rp_money - 20;
			trace_ent.rp_owner = self;
		}
	}
	else if (trace_ent.classname == "func_movewall")
	{
		if(trace_ent.rp_owner == self)
		{
			centerprint(self, "You already own this door.");
			self.rp_menutime = time + 2;
		}
		else if (trace_ent.rp_owner == world)
		{
			if(!RP_CheckMoney(20))
			{
				centerprint(self, "You don't have enough money to buy this.");
				self.rp_menutime = time + 2;
				return;
			}
			
			centerprint(self, "You bought this door for $20!");
			stuffcmd(self, "play roleplay/cash.wav\n");
			
			self.rp_menutime = time + 2;
			self.rp_money = self.rp_money - 20;
			trace_ent.owner.rp_owner = self;
		}

	}

};

void() RP_SellDoor =
{
	local	vector	source;

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "door")
	{
		if(trace_ent.rp_owner == self)
		{
			centerprint(self, "You sold this door for $10!");
			self.rp_menutime = time + 2;
			self.rp_money = self.rp_money + 10;
			trace_ent.rp_owner = world;
		}
		else
		{
			centerprint(self, "You don't own this door");
			self.rp_menutime = time + 2;
		}
	}
	else if (trace_ent.classname == "func_movewall")
	{
		if(trace_ent.rp_owner == self)
		{
			centerprint(self, "You sold this door for $10!");
			self.rp_menutime = time + 2;
			self.rp_money = self.rp_money + 10;
			trace_ent.owner.rp_owner = world;
		}
		else
		{
			centerprint(self, "You don't own this door");
			self.rp_menutime = time + 2;
		}
	}

};

void() RP_Arrest =
{
	local	vector	source;
		
	if(!RP_CheckJob(JOB_POLICEFORCE, self))
		return;
		

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "player")
	{
		trace_ent.items = 0;
		trace_ent.weapon = 0;
		trace_ent.currentammo = 0;
		trace_ent.weaponmodel = "";
		trace_ent.weaponframe = 0;
		bprint (trace_ent.netname);
		bprint (" has been arrested.\n");
	}
	
};

void() RP_Unarrest =
{
	local	vector	source;
		
	if(!RP_CheckJob(JOB_POLICEFORCE, self))
		return;
		

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "player")
	{
		trace_ent.items		= IT_AXE | IT_KEYS;
		trace_ent.weapon 	= IT_KEYS;
		RP_SetCurrentAmmo(trace_ent);
		
		bprint (trace_ent.netname);
		bprint (" has been unarrested.\n");
	}
};

void() RP_LockPickAttempt =
{
		local	vector	source;
		local float r;

		makevectors (self.v_angle);
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward*124, FALSE, self);

		if (trace_ent.classname == "door" || trace_ent.classname == "rotate_object")
		{
			if(trace_ent.rp_owner != self)
			{
				if(trace_ent.rp_locked)
				{
					r = random();
					
					if(r < 0.1)
					{
						centerprint(self, "Your door is now unlocked.");
						self.rp_menutime = time + 2;
						trace_ent.rp_locked = 0;
						sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
					}
					else
					{
						centerprint(self, "Lockpicking failed.");
						self.rp_menutime = time + 2;
						sound (self, CHAN_AUTO, "player/axhit2.wav", 1, ATTN_NORM);
					}
				}
			}
			else
			{
				centerprint(self, "You can't lockpick your own door.");
				self.rp_menutime = time + 2;
			}
		}
};

void() RP_SellShotgun =
{
	local	vector	source;
	
	if(!RP_CheckJob(JOB_GUNDEALER, self))
		return;

	if(!RP_CheckMoney(150))
	{
		centerprint(self, "You don't have enough money to buy a shotgun.");
		self.rp_menutime = time + 2;
		return;
	}

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "player")
	{
		if(RP_CheckInventory(IT_SHOTGUN, trace_ent))
		{
			centerprint(self, "This player already has a shotgun.");
			self.rp_menutime = time + 2;
			return;
		}
			
		trace_ent.items = trace_ent.items | IT_SHOTGUN;
		trace_ent.ammo_shells = trace_ent.ammo_shells + 25;
		self.rp_money = self.rp_money - 150;
		
		centerprint(self, "Bought him a shotgun for $150.");
		centerprint(trace_ent, "You received a shotgun.");
		stuffcmd(self, "play roleplay/cash.wav\n");
	}
};

void() RP_SellShells =
{
	local	vector	source;
	if(!RP_CheckJob(JOB_GUNDEALER, self))
		return;
		
	if(!RP_CheckMoney(50))
	{
		centerprint(self, "You don't have enough money to buy shotgun shells.");
		self.rp_menutime = time + 2;
		return;
	}

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "player")
	{
		trace_ent.ammo_shells = trace_ent.ammo_shells + 25;
		self.rp_money = self.rp_money - 50;
		
		centerprint(trace_ent, "You received some shells.");
		centerprint(self, "Bought him shells for $50.");
		stuffcmd(self, "play roleplay/cash.wav\n");
	}
};

void() RP_HealPlayer =
{
	local	vector	source;
	if(!RP_CheckJob(JOB_MEDIC, self))
		return;

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	if (trace_ent.classname == "player")
	{
		if(trace_ent.health >= 100)
		{
			centerprint(self, "This player already is at full health.");
			self.rp_menutime = time + 2;
			return;
		}
		
		trace_ent.health = 100;
		
		stuffcmd(self, "play items/suit.wav\n");
		stuffcmd(trace_ent, "play items/suit.wav\n");
	}
};

void() RP_SwitchLockdown =
{
	if(rp_lockdown == TRUE)
	{
		sound(world.rp_lockdownspeaker, CHAN_VOICE, "misc/null.wav", 1, ATTN_NONE);
		bprint("<<< THE MAYOR ENDED THE LOCKDOWN >>>");
		rp_lockdown = FALSE;
	}
	else
	{
		sound(world.rp_lockdownspeaker, CHAN_VOICE, "roleplay/lockdown.wav", 1, ATTN_NONE);
		bprint("<<< THE MAYOR STARTED A LOCKDOWN >>>");
		rp_lockdown = TRUE;
	}
};

void() RP_DropMoney_Touch =
{
	local	string money;
	
	if(!(other.classname == "player"))
		return;
	
	money = ftos(self.health);
	centerprint(other, "You have found $", money, "!\n");
	other.rp_menutime = time + 2;
	
	stuffcmd(other, "play items/health1.wav\n");
	
	other.rp_money = other.rp_money + self.health;
	remove(self);
};

void(float amount) RP_DropMoney =
{
	local	vector	source;

	local	entity 	new;
	local	string money;
	
	if(!RP_CheckMoney(amount))
	{
		centerprint(self, "You don't have enough money to drop.");
		self.rp_menutime = time + 2;
		return;
	}
	
	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	
	new = spawn();
	new.origin = trace_endpos;
	setmodel (new, "progs/rp_money.mdl");
	new.classname = "money";
	new.solid = SOLID_TRIGGER;
	new.touch = RP_DropMoney_Touch;
	new.health = amount;
	new.rp_owner = self;
	new.movetype = MOVETYPE_BOUNCE;
	setsize (new, '-9 -12 0', '9 12 7');
	
	money = ftos(amount);
	centerprint(self, "You have dropped $", money, "!\n");
	self.rp_menutime = time + 1;
	self.rp_money = self.rp_money - amount;
};