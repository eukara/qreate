// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

// Alternative Spawn Menu
// Written by eukos/eukara for qreate 0.8

void() qreate_altspawnmenu_draw =
{
	if(self.rp_menutime > time)
		return;
		
	self.rp_menutime = time + 0.75;

	if(self.qreate_altmenulst == 0)
		centerprint(self, "\n  QREATE SPAWNMENU  \n\n  ) MONSTERS       \n  ) PROPS          \n  ) ITEMS          \n  ) WEAPONS        \n                    \n  ) QUIT           \n\n\nPRESS  TO RETURN TO THIS MENU");
	else if(self.qreate_altmenulst == 1)
		centerprint(self, "\n  MONSTER LIST            (1/3)  \n\n  ) monster_army                \n  ) monster_boss                \n  ) monster_demon1              \n  ) monster_dog                 \n  ) monster_enforcer            \n  ) monster_fish                \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 2)
		centerprint(self, "\n  MONSTER LIST            (2/3)  \n\n  ) monster_hell_knight         \n  ) monster_knight              \n  ) monster_ogre                \n  ) monster_oldone              \n  ) monster_shalrath            \n  ) monster_shambler            \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 3)
		centerprint(self, "\n  MONSTER LIST            (3/3)  \n\n  ) monster_tarbaby             \n  ) monster_wizard              \n  ) monster_zombie              \n                                 \n                                 \n                                 \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 4)
		centerprint(self, "\n  PROP LIST     (1/4)  \n\n  ) prop_player       \n  ) prop_wall1        \n  ) prop_wall2        \n  ) prop_floor        \n  ) prop_dragon       \n  ) prop_torch        \n  ) next ç            \n");
	else if(self.qreate_altmenulst == 5)
		centerprint(self, "\n  PROP LIST     (2/4)  \n\n  ) prop_army         \n  ) prop_boss         \n  ) prop_demon1       \n  ) prop_dog          \n  ) prop_enforcer     \n  ) prop_fish         \n  ) next ç            \n");
	else if(self.qreate_altmenulst == 6)
		centerprint(self, "\n  PROP LIST     (3/4)  \n\n  ) prop_hell_knight  \n  ) prop_knight       \n  ) prop_ogre         \n  ) prop_oldone       \n  ) prop_shalrath     \n  ) prop_shambler     \n  ) next ç            \n");
	else if(self.qreate_altmenulst == 7)
		centerprint(self, "\n  PROP LIST     (4/4)  \n\n  ) prop_tarbaby      \n  ) prop_wizard       \n  ) prop_zombie       \n                       \n                       \n                       \n  ) next ç            \n");
	else if(self.qreate_altmenulst == 8)
		centerprint(self, "\n  ITEM LIST               (1/3)  \n\n  ) item_armor1                 \n  ) item_armor2                 \n  ) item_armorInv               \n  ) item_artifact_envirosuit    \n  ) item_artifact_invisibility  \n  ) item_artifact_super_damage  \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 9)
		centerprint(self, "\n  ITEM LIST               (2/3)  \n\n  ) item_cells                  \n  ) item_health                 \n  ) item_key1                   \n  ) item_key2                   \n  ) item_rockets                \n  ) item_shells                 \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 10)
		centerprint(self, "\n  ITEM LIST               (3/3)  \n\n  ) item_spikes                 \n                                 \n                                 \n                                 \n                                 \n                                 \n  ) next ç                      \n");
	else if(self.qreate_altmenulst == 11)
		centerprint(self, "\n  WEAPON LIST               \n\n  ) weapon_shotgun         \n  ) weapon_supershotgun    \n  ) weapon_nailgun         \n  ) weapon_supernailgun    \n  ) weapon_grenadelauncher \n  ) weapon_rocketlauncher  \n  ) weapon_lighting        \n");

};

void() qreate_altspawnmenut_draw =
{
	if(self.rp_menutime > time)
		return;
		
	self.rp_menutime = time + 0.75;

	if(self.qreate_altmenulstt == 0)
		centerprint(self, "\n  TOOL LIST          (1/2)  \n\n  ) remove tool            \n  ) rotate x axis          \n  ) rotate y axis          \n  ) rotate z axis          \n  ) move x axis            \n  ) move y axis            \n  ) next ç                 \n");
	else if(self.qreate_altmenulstt == 1)
		centerprint(self, "\n  TOOL LIST          (2/2)  \n\n  ) move z axis            \n  ) change skin            \n  ) change frame           \n  ) change effects         \n  ) quake breaker!         \n  ) switch viewpoint       \n  ) next ç                 \n");
}

void() qreate_altspawnmenu_switch =
{
	if(self.qreate_altmenu == TRUE)
	{
		centerprint(self, " ");
		self.qreate_altmenu = FALSE;
	}
	else
	{
		self.qreate_altmenut = FALSE;
		self.qreate_altmenu = TRUE;
	}
};

void() qreate_altspawnmenut_switch =
{
	if(self.qreate_altmenut == TRUE)
	{
		centerprint(self, " ");
		self.qreate_altmenut = FALSE;
	}
	else
	{
		self.qreate_altmenut = TRUE;
		self.qreate_altmenu = FALSE;
	}
};

void(float toolnr) qreate_altmenutool =
{
	self.tselected = toolnr;
	stuffcmd (self, "play effects/switch01.wav\n");
};

float() qreate_altspawnmenu_input =
{
	if(self.qreate_altmenu == FALSE)
		return FALSE;

	if(self.impulse == 1)
	{
		if(self.qreate_altmenulst == 0)
			self.qreate_altmenulst = 1;
		else if(self.qreate_altmenulst == 1)
			qreate_spawn (monster_army);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_hell_knight);
		else if(self.qreate_altmenulst == 3)
			qreate_spawn (monster_tarbaby);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (qreate_prop_player);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_army);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_hknight);
		else if(self.qreate_altmenulst == 7)
			qreate_spawn (qreate_prop_tarbaby);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_armor1);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_cells);
		else if(self.qreate_altmenulst == 10)
			qreate_spawn (item_spikes);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_supershotgun);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(0);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(6);


		return TRUE;
	}
	else if(self.impulse == 2)
	{
		if(self.qreate_altmenulst == 0)
			self.qreate_altmenulst = 4;
		else if(self.qreate_altmenulst == 1)
			qreate_spawn (boss_awake);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_knight);
		else if(self.qreate_altmenulst == 3)
			qreate_spawn (monster_wizard);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (qreate_prop_wall);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_boss);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_knight);
		else if(self.qreate_altmenulst == 7)
			qreate_spawn (qreate_prop_wizard);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_armor2);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_health);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_supershotgun);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(1);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(7);
		return TRUE;
	}
	else if(self.impulse == 3)
	{
		if(self.qreate_altmenulst == 0)
			self.qreate_altmenulst = 8;
		else if(self.qreate_altmenulst == 1)
			qreate_spawn (monster_demon1);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_ogre);
		else if(self.qreate_altmenulst == 3)
			qreate_spawn (monster_zombie);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (qreate_prop_wall2);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_demon);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_ogre);
		else if(self.qreate_altmenulst == 7)
			qreate_spawn (qreate_prop_zombie);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_armorInv);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_key1);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_nailgun);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(2);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(8);
		return TRUE;
	}
	else if(self.impulse == 4)
	{
		if(self.qreate_altmenulst == 0)
			self.qreate_altmenulst = 11;
		else if(self.qreate_altmenulst == 1)
			qreate_spawn (monster_dog);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_oldone);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (qreate_prop_floor);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_dog);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_oldone);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_artifact_envirosuit);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_key2);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_supernailgun);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(3);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(9);
		return TRUE;
	}
	else if(self.impulse == 5)
	{
		if(self.qreate_altmenulst == 1)
			qreate_spawn (monster_enforcer);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_shalrath);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (qreate_prop_dragon);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_enforcer);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_shalrath);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_artifact_invisibility);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_rockets);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_grenadelauncher);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(4);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(10);
		return TRUE;

	}
	else if(self.impulse == 6)
	{
		if(self.qreate_altmenulst == 1)
			qreate_spawn (monster_fish);
		else if(self.qreate_altmenulst == 2)
			qreate_spawn (monster_shambler);
		else if(self.qreate_altmenulst == 4)
			qreate_spawn (prop_torch);
		else if(self.qreate_altmenulst == 5)
			qreate_spawn (qreate_prop_fish);
		else if(self.qreate_altmenulst == 6)
			qreate_spawn (qreate_prop_shambler);
		else if(self.qreate_altmenulst == 8)
			qreate_spawn (item_artifact_super_damage);
		else if(self.qreate_altmenulst == 9)
			qreate_spawn (item_shells);
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_rocketlauncher);
		else if(self.qreate_altmenulst == 12)
			qreate_altmenutool(5);
		else if(self.qreate_altmenulst == 13)
			qreate_altmenutool(11);
		return TRUE;

	}
	else if(self.impulse == 7)
	{
		if(self.qreate_altmenulst == 1)
			self.qreate_altmenulst = 2;
		else if(self.qreate_altmenulst == 2)
			self.qreate_altmenulst = 3;
		else if(self.qreate_altmenulst == 3)
			self.qreate_altmenulst = 1;
		else if(self.qreate_altmenulst == 4)
			self.qreate_altmenulst = 5;
		else if(self.qreate_altmenulst == 5)
			self.qreate_altmenulst = 6;
		else if(self.qreate_altmenulst == 6)
			self.qreate_altmenulst = 7;
		else if(self.qreate_altmenulst == 7)
			self.qreate_altmenulst = 4;
		else if(self.qreate_altmenulst == 8)
			self.qreate_altmenulst = 9;
		else if(self.qreate_altmenulst == 9)
			self.qreate_altmenulst = 10;
		else if(self.qreate_altmenulst == 10)
			self.qreate_altmenulst = 8;
		else if(self.qreate_altmenulst == 11)
			qreate_spawn (weapon_lightning);
		else if(self.qreate_altmenulst == 12)
			self.qreate_altmenulst = 13;
		else if(self.qreate_altmenulst == 13)
			self.qreate_altmenulst = 12;

		return TRUE;

	}
	else if(self.impulse == 19)
	{
		if(self.qreate_altmenulst != 0)
		self.qreate_altmenulst = 0;
		else
		{
		self.qreate_altmenu = FALSE;
		centerprint(self, " ");
		}

		return TRUE;
	}

	return FALSE;
};

float() qreate_altspawnmenut_input =
{
	if(self.qreate_altmenut == FALSE)
		return FALSE;

	if(self.impulse == 1)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(0);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(6);

		return TRUE;
	}
	else if(self.impulse == 2)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(1);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(7);
		return TRUE;
	}
	else if(self.impulse == 3)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(2);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(8);
		return TRUE;
	}
	else if(self.impulse == 4)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(3);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(9);
		return TRUE;
	}
	else if(self.impulse == 5)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(4);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(10);
		return TRUE;

	}
	else if(self.impulse == 6)
	{
		if(self.qreate_altmenulstt == 0)
			qreate_altmenutool(5);
		else if(self.qreate_altmenulstt == 1)
			qreate_altmenutool(11);
		return TRUE;

	}
	else if(self.impulse == 7)
	{
		if(self.qreate_altmenulstt == 0)
			self.qreate_altmenulstt = 1;
		else if(self.qreate_altmenulstt == 1)
			self.qreate_altmenulstt = 0;

		return TRUE;

	}

	return FALSE;
};
