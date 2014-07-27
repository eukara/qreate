// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

float() qreate_CheckHIPNOTIC =
{
	if(mapname == "hip1m1" ||
		mapname == "hip1m2" ||
		mapname == "hip1m3" ||
		mapname == "hip1m4" ||
		mapname == "hip1m5" ||
		mapname == "hip2m1" ||
		mapname == "hip2m2" ||
		mapname == "hip2m3" ||
		mapname == "hip2m4" ||
		mapname == "hip2m5" ||
		mapname == "hip2m6" ||
		mapname == "hip3m1" ||
		mapname == "hip3m2" ||
		mapname == "hip3m3" ||
		mapname == "hip3m4" ||
		mapname == "hipdm1" ||
		mapname == "hipend")
		return TRUE;
	else
		return FALSE;
};
float() qreate_CheckROGUE =
{
	if(mapname == "ctf1" ||
		mapname == "r1m1" ||
		mapname == "r1m2" ||
		mapname == "r1m3" ||
		mapname == "r1m4" ||
		mapname == "r1m5" ||
		mapname == "r1m6" ||
		mapname == "r1m7" ||
		mapname == "r2m1" ||
		mapname == "r2m2" ||
		mapname == "r2m3" ||
		mapname == "r2m4" ||
		mapname == "r2m5" ||
		mapname == "r2m6" ||
		mapname == "r2m7" ||
		mapname == "r2m8" )
		return TRUE;
	else
		return FALSE;
};
float() qreate_CheckLIGHTRP =
{
	if(world.mode == 2)
		return TRUE;
	else
		return FALSE;
};

void() qreate_arcade =
{
	precache_model ("progs/qrcad1.mdl");
	setmodel(self, "progs/qrcad1.mdl");
	setorigin(self, self.origin + '0 0 -30');
}

void() qreate_serversidenoclip =
{
	if(self.movetype == MOVETYPE_NOCLIP)
	{
		self.movetype = MOVETYPE_WALK;
		sprint(self, "noclip off\n");
	}
	else
	{
		self.movetype = MOVETYPE_NOCLIP;
		sprint(self, "noclip on\n");
	}
}

void(entity player) qreate_cleanup =
{
	local entity    finder;

        finder = findradius (self.origin, 20000);

        while(finder) 
        {
                if(finder.spawner == player)
			remove(finder);

                finder = finder.chain;
        }
};
