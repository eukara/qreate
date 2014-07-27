// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

void() qreate_vehicle_touch =
{
	vector newpos;

	if(other.classname != "player")
		return;

	self.velocity = '0 0 0';

        if ((!other.flags & FL_ONGROUND) && (other.health) && (other.flags & FL_CLIENT))
                other.flags = other.flags + FL_ONGROUND;

	makevectors (self.v_angle);

	if(!other.inveh)
	{
		newpos_x = self.origin_x;
		newpos_y = self.origin_y;
		newpos_z = other.origin_z;
		other.inveh = 1;
		self.cam = other;
		setorigin(other, newpos);
	}
	else
	{
		self.angles_y = other.angles_y;
		newpos_x = other.origin_x;
		newpos_y = other.origin_y;
		newpos_z = other.origin_z - 24;
	//	setorigin(self,newpos);
	}

	newpos_z = self.origin_z + v_up_z*-512;
	traceline (self.origin, newpos, FALSE, self);
	newpos_z = trace_endpos_z + 9;

	if(trace_ent.classname == "worldspawn" && trace_fraction != 1.0)
		setorigin(self, newpos);
};
void() qreate_vehicle =
{
	precache_model(self.model);
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BBOX; // Was SOLID_BSP
	self.touch = qreate_vehicle_touch;
	setmodel (self, self.model);
	setorigin(self, self.origin);
	setsize(self, '-24 -14 0', '24 14 8'); // Added after SOLID change
};
