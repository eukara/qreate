// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY JOBS
// *******

void() W_SetCurrentAmmo;

// Called when the player spawns for the FIRST time
void() RP_Job_Init =
{
	if (self.rp_job == JOB_CITIZEN)
	{
		self.rp_title 	= "Citizen";
		self.rp_salary 	= 50;
		self.items 		= IT_AXE | IT_KEYS;
		self.weapon 	= IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 7;
	}
	else if (self.rp_job == JOB_POLICEFORCE)
	{
		self.rp_title = "Police Force";
		self.rp_salary = 90;
		self.items = IT_AXE | IT_KEYS | IT_SHOTGUN;
		self.weapon = IT_KEYS;
		self.ammo_shells = 25;
		self.skin = 6;
	}
	else if (self.rp_job == JOB_MOBSTER)
	{
		self.rp_title = "Mobster";
		self.rp_salary = 50;
		self.items = IT_AXE | IT_KEYS;
		self.weapon = IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 5;
	}
	else if (self.rp_job == JOB_GUNDEALER)
	{
		self.rp_title = "Gun Dealer";
		self.rp_salary = 60;
		self.items = IT_AXE | IT_KEYS;
		self.weapon = IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 4;
	}
	else if (self.rp_job == JOB_MEDIC)
	{
		self.rp_title = "Medic";
		self.rp_salary = 80;
		self.items = IT_AXE | IT_KEYS;
		self.weapon = IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 3;
	}
	else if (self.rp_job == JOB_MERCHANT)
	{
		self.rp_title = "Merchant";
		self.rp_salary = 50;
		self.items = IT_AXE | IT_KEYS;
		self.weapon = IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 2;
	}
	else if (self.rp_job == JOB_MAYOR)
	{
		self.rp_title = "Mayor";
		self.rp_salary = 200;
		self.items = IT_AXE | IT_KEYS;
		self.weapon = IT_KEYS;
		self.ammo_shells = 0;
		self.skin = 1;
	}
	
	W_SetCurrentAmmo ();
	stuffcmd (self, "bf\n");

};

void() RP_Job_Menu =
{
	if (self.rp_job == JOB_CITIZEN)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_POLICEFORCE)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Arrest              |\n|4: Unarrest            |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_MOBSTER)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Attempt Lockpicking |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_GUNDEALER)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Sell Shotgun ($150) |\n|4: Sell Shells ($150)  |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_MEDIC)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Heal Player	        |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_MERCHANT)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Buy Watermelon ($15)|\n|4: Buy Basketball ($30)|\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}
	else if (self.rp_job == JOB_MAYOR)
	{
		centerprint(self,"|-----------------------|\n|   LIGHT RP FUNCTIONS  |\n|-----------------------|\n|0: Switch To Keys      |\n|1: Buy Door            |\n|2: Sell Door           |\n|-----------------------|\n|3: Start Lockdown      |\n|-----------------------|\n|7: Drop $10            |\n|8: Drop $100           |\n|9: MoneyPrinter ($500) |\n|-----------------------|\n");
	}

};

float(float id) RP_FindJobs =
{
	local entity pl;
	
	pl = findradius (self.origin, 10000);
    while(pl)
    {
		if((pl.classname == "player") && (pl.rp_job == id)) 
            return TRUE;
        pl = pl.chain;
    }
	
	return FALSE;
};

void() PutClientInServer;

void(float id) RP_SetJob =
{
	if(self.rp_job == id)
	{
		centerprint(self, "You already have this job!");
		self.rp_menutime = time + 2;
		return;
	}
	
	if (!id >= JOB_CITIZEN && !id <= JOB_MAYOR) // First job is Citizen and last job is Mayor
	{
		dprint("Invalid Job class! Check rp_jobs.qc!");
		return;
	}
	
	self.rp_job = id;
	PutClientInServer();
	
	bprint (self.netname);
	bprint (" became a ");
	bprint (self.rp_title);
	bprint (".\n");

};
