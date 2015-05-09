// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redistribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY HUD
// *******
// Based off http://www.quake-1.com/docs/quakesrc.org/49.html

void() RP_PlayerID =
{
	local vector	src;
	local string	trackp;
	
	if(self.rp_menutime > time)
	return;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*124, FALSE, self);
	
		if (trace_ent.classname == "player" && trace_ent.health > 0)
		{
				trackp = ftos(trace_ent.health);
				lightrp_centerprintb(self, "Name: ",trace_ent.netname, "\nHealth: ", trackp, "\nJob: ",trace_ent.rp_title, "", "", "", "", "", "", "", "", "\n");
		}
		else if (trace_ent.classname == "door")
		{
			if(trace_ent.rp_owner == world)
				centerprint(self, "Unowned Door\n-Buy for 20$-\n");
			else
				lightrp_centerprintb(self, "Owned by ",trace_ent.rp_owner.netname, "", "", "", "", "", "", "", "", "", "", "", "", "\n");
		}
		else if (trace_ent.classname == "func_movewall")
		{
			if(trace_ent.owner.rp_owner == world)
				centerprint(self, "Unowned Door\n-Buy for 20$-\n");
			else
				lightrp_centerprintb(self, "Owned by ",trace_ent.owner.rp_owner.netname, "", "", "", "", "", "", "", "", "", "", "", "", "\n");

		}
		
	self.rp_menutime = time + 1;
};
