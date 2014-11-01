// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY MENU
// *******
void() RP_SpawnMoneyPrinter;
void() RP_Watermelon_Spawn;
void() RP_Basketball_Spawn;
				
void() RP_FuncMenu_Draw =
{
	if(!self.rp_infmenu)
		return;
	
	RP_Job_Menu();
};

void() RP_Menu_Draw =
{
	if(self.rp_menutime > time)
		return;
		
	RP_PlayerID();
	RP_FuncMenu_Draw();
	
	self.rp_menutime = time + 1;
	if(!self.rp_inmenu)
		return;
		
	lightrp_centerprintb(self, "|-----------------------|\n|LIGHT ROLEPLAY Job Menu|\n|-----------------------|\n|1: ", world.TITLE_JOB_CITIZEN, "            |\n|2: ", world.TITLE_JOB_POLICEFORCE, "        |\n|3: ", world.TITLE_JOB_MOBSTER, "             |\n|4: ", world.TITLE_JOB_GUNDEALER, "          |\n|5: ", world.TITLE_JOB_MEDIC, "               |\n|6: ", world.TITLE_JOB_MERCHANT, "            |\n|7: ", world.TITLE_JOB_MAYOR, "               |\n|-----------------------|\n");
};
void() RP_InfoMenu_Draw =
{
	string money;
	
	money = ftos(self.rp_money);
	centerprint (self, "|-----------------------|\n|     LIGHT RP STATS    |\n|-----------------------|\n\nName: ", self.netname,"\nJob: ", self.rp_title,"\nMoney: $", money,"\n");
};

void() RP_Menu_Switch =
{
	if(self.rp_inmenu)
		self.rp_inmenu = FALSE;
	else
		self.rp_inmenu = TRUE;
		
	self.rp_infmenu = FALSE;
};

void() RP_FuncMenu_Switch =
{
	if(self.rp_infmenu)
		self.rp_infmenu = FALSE;
	else
		self.rp_infmenu = TRUE;
		
	self.rp_inmenu = FALSE;
};

float() RP_Menu_Input =
{
	if(self.impulse == 20)
		RP_Menu_Switch();
	if(self.impulse == 21)
		RP_InfoMenu_Draw();
	if(self.impulse == 22)
		RP_FuncMenu_Switch();

	if(self.impulse == 57)
		self.secfire = 1;
	if(self.impulse == 58)
		self.secfire = 0;
	
	
	if(self.rp_infmenu)
	{
		if(self.impulse == 1)
			RP_BuyDoor();
		else if(self.impulse == 2)
			RP_SellDoor();
		else if(self.impulse == 7)
			RP_DropMoney(10);
		else if(self.impulse == 8)
			RP_DropMoney(100);
		else if(self.impulse == 9)
			RP_SpawnMoneyPrinter();
		else if(self.impulse == 19)
		{
			if(self.items)
			{
				self.weapon = IT_KEYS;
				RP_SetCurrentAmmo(self);
			}
		}
		else if(self.rp_job == JOB_POLICEFORCE)
		{
			if(self.impulse == 3)
				RP_Arrest();
			else if(self.impulse == 4)
				RP_Unarrest();
			else
				return FALSE;
		}
		else if(self.rp_job == JOB_MOBSTER)
		{
			if(self.impulse == 3)
				RP_LockPickAttempt();
			else
				return FALSE;
		}
		else if (self.rp_job == JOB_GUNDEALER)
		{
			if(self.impulse == 3)
				RP_SellShotgun();
			else if(self.impulse == 4)
				RP_SellShells();
			else
				return FALSE;
		}
		else if (self.rp_job == JOB_MEDIC)
		{
			if(self.impulse == 3)
				RP_HealPlayer();
			else
				return FALSE;
		}
		else if (self.rp_job == JOB_MERCHANT)
		{
			if(self.impulse == 3)
				RP_Watermelon_Spawn();
			else if(self.impulse == 4)
				RP_Basketball_Spawn();
			else
				return FALSE;
		}
		else if (self.rp_job == JOB_MAYOR)
		{
			if(self.impulse == 3)
				RP_SwitchLockdown();
			else
				return FALSE;
		}	
		else
			return FALSE;
	}
	else if (self.rp_inmenu)
	{
	if(self.impulse == 1)
		RP_SetJob(JOB_CITIZEN);
	else if(self.impulse == 2)
		RP_SetJob(JOB_POLICEFORCE);
	else if(self.impulse == 3)
		RP_SetJob(JOB_MOBSTER);
	else if(self.impulse == 4)
		RP_SetJob(JOB_GUNDEALER);
	else if(self.impulse == 5)
		RP_SetJob(JOB_MEDIC);
	else if(self.impulse == 6)
		RP_SetJob(JOB_MERCHANT);
	else if(self.impulse == 7)
		RP_SetJob(JOB_MAYOR);
	else
	{
		return FALSE;
	}
	
	}
	else
	{
		return FALSE;
	}

	self.rp_inmenu = FALSE;
	self.rp_infmenu = FALSE;
	self.impulse = 0;
	return TRUE;
};