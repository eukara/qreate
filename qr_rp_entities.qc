// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

// *******
// LIGHT ROLEPLAY ENTITIES
// *******

void() RP_MoneyPrinterPrint;
void() RP_MoneyPrinterFX =
{
	local	entity new;
	local float rand12;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, "progs/rp_money.mdl");
	new.movetype = MOVETYPE_BOUNCE;
	new.velocity = VelocityForDamage (-42);
	new.flags = FL_ITEM;
	new.solid = SOLID_TRIGGER;

	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;

	new.nextthink = time + 1.5;
	new.think = SUB_Remove;
};

void() RP_MoneyPrinterExplode =
{
	centerprint (self.rp_owner, "One money printer has exploded.");
	self.rp_owner.rp_menutime = time + 2;
	
	BecomeExplosion();
};

void() RP_MoneyPrinterPrintPay =
{
	self.rp_owner.rp_money = self.rp_owner.rp_money + 100;
	centerprint (self.rp_owner, "You gained $100 from your money printer.");
	self.rp_owner.rp_menutime = time + 2;
	
	self.nextthink = time + 200;
	self.think = RP_MoneyPrinterPrint;
};

void() RP_MoneyPrinterPrint =
{
	local float i;
		
	while ( i < 10 )
	{
		RP_MoneyPrinterFX();
		i = i + 1;
	}

		self.nextthink = time + 1.5;
		self.think = RP_MoneyPrinterPrintPay;
};

void() RP_SpawnMoneyPrinter =
{
	local	vector	source;
	local	vector	org;
	local	entity 	new;
	
	if(!RP_CheckMoney(500))
	{
		centerprint(self, "You don't have enough money to buy this.");
		self.rp_menutime = time + 2;
		return;
	}

	self.rp_money = self.rp_money - 500;		
	stuffcmd(self, "play roleplay/cash.wav\n");
	
	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);
	
	sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
	new = spawn();
	new.origin = trace_endpos;
	setmodel (new, "progs/rp_printer.mdl");
	new.classname = "moneyprinter";
	new.health = 100;
	new.max_health = self.health;
	new.th_die = RP_MoneyPrinterExplode;
	new.takedamage = DAMAGE_YES;
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_BBOX;
	new.rp_owner = self;
	setsize (new, '-9 -12 0', '9 12 7');
	
	new.nextthink = time + 10.5;
	new.think = RP_MoneyPrinterPrint;
};

void() RP_Watermelon_Rave =
{		
	local	float	r;
	
	if(self.health < time)
	{
		stuffcmd(self.rp_owner, "v_cshift 0 0 0 0\n");
		remove(self);
		return;
	}
	
	if (self.armorvalue)
	{
		self.rp_owner.punchangle_x = -15;
		stuffcmd(self.rp_owner, "v_cshift 76 255 0 70\n");
		self.armorvalue = 0;
	}
	else
	{
		self.rp_owner.punchangle_x = 15;
		stuffcmd(self.rp_owner, "v_cshift 255 140 0 70\n");
		self.armorvalue = 1;
	}
	
	stuffcmd (self.rp_owner, "bf\n");
	self.think = RP_Watermelon_Rave;
	self.nextthink = time + 0.1;
};

void() RP_Watermelon_Touch =
{	
	if (!other.classname == "player")
		return;
		
	other.health = 200;
	
	self.model = "";
	self.solid = SOLID_NOT;
	
	sound (other, CHAN_AUTO, "roleplay/rave.wav", 1, ATTN_NORM);
	
	self.rp_owner = other;
	self.think = RP_Watermelon_Rave;
	self.nextthink = time;
	self.health = time + 14;
};
void() RP_Watermelon_Spawn =
 {
	local	vector	source;
	local	vector	org;
	local	entity 	new;
	
	if(!RP_CheckMoney(15))
	{
		centerprint(self, "You don't have enough money to buy this.");
		self.rp_menutime = time + 2;
		return;
	}

	self.rp_money = self.rp_money - 15;		
	stuffcmd(self, "play roleplay/cash.wav\n");
	
	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	new = spawn();
	new.origin = trace_endpos + '0 0 6';
	new.solid = SOLID_TRIGGER;
	new.movetype = MOVETYPE_BOUNCE;
	new.classname = "watermelon";
	new.health = 3;

	setmodel (new, "progs/rp_melon.mdl");	
	setsize (new, '-6 -6 -6', '6 6 6');
	new.touch = RP_Watermelon_Touch;

};

void() RP_BasketBall_Touch =
{
	local vector v;

	// only a player can kick it
	if (other.classname != "basketball" && other.classname != "player" && other.classname != "qreate_vehicle")
	{
		if(!self.health)
		return;
		
		self.velocity_z = self.velocity_z *2+20*self.health;
		self.health = self.health - 1;
		sound (self, CHAN_AUTO, "roleplay/bounce.wav", 0.6, ATTN_NORM);
	}
	else
	{

		v_x = (other.velocity_x*2+50*random());
		v_y = (other.velocity_y*2+50*random());
		self.health = 5;
		
		if(other.classname == "player")
		v_z = 250;

		self.flags = self.flags - ( self.flags & FL_ONGROUND );
		self.velocity = v;
		self.avelocity = v;
		sound (self, CHAN_AUTO, "roleplay/bounce.wav", 0.6, ATTN_NORM);
	}
};
void() RP_Basketball_Spawn =
 {
	local	vector	source;
	local	vector	org;
	local	entity 	new;
	
	if(!RP_CheckMoney(30))
	{
		centerprint(self, "You don't have enough money to buy this.");
		self.rp_menutime = time + 2;
		return;
	}
	
	self.rp_money = self.rp_money - 30;	
	stuffcmd(self, "play roleplay/cash.wav\n");
	
	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*124, FALSE, self);

	new = spawn();
	new.origin = trace_endpos + '0 0 6';
	new.solid = SOLID_TRIGGER;
	new.movetype = MOVETYPE_BOUNCE;
	new.classname = "basketball";
	new.health = 3;

	setmodel (new, "progs/rp_ball.mdl");	
	setsize (new, '-6 -6 -6', '6 6 6');
	new.touch = RP_BasketBall_Touch;

};

// LIGHTRP Mapping Ents

void() rp_prop_bounce_use =
{
};

void() rp_prop_bounce_touch =
{
	local vector v;

	// only a player can kick it
	if (other.classname != "basketball" && other.classname != "player" && other.classname != "qreate_vehicle")
	{
		if(!self.health)
		return;
		
		self.velocity_z = self.velocity_z * 2+20 * self.health * self.style;
		self.health = self.health - 1;
		sound (self, CHAN_AUTO, self.noise, 0.6, ATTN_NORM);
	}
	else
	{

		v_x = (other.velocity_x*2+50*random()) * self.style;
		v_y = (other.velocity_y*2+50*random()) * self.style;
		self.health = 5;
		
		if(other.classname == "player")
		v_z = 250;

		self.flags = self.flags - ( self.flags & FL_ONGROUND );
		self.velocity = v;
		self.avelocity = v;
		sound (self, CHAN_AUTO, self.noise, 0.6, ATTN_NORM);
	}
};

void() rp_prop_bounce =
{
	precache_model (self.model);
	precache_sound (self.noise);

	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_BOUNCE;
	self.health = 3;

	setmodel (self, self.model);	
	setsize (self, '-6 -6 -6', '6 6 6');
	self.touch = rp_prop_bounce_touch;

};

void() rp_item_money =
{
	setmodel (self, self.model);
	self.classname = "money";
	self.solid = SOLID_TRIGGER;
	self.touch = RP_DropMoney_Touch;
	self.movetype = MOVETYPE_BOUNCE;
	setsize (self, '-9 -12 0', '9 12 7');
}

void() rp_item_melon =
{
	setmodel (self, "progs/rp_melon.mdl");
	self.classname = "watermelon";
	self.solid = SOLID_TRIGGER;
	self.touch = RP_Watermelon_Touch;
	self.movetype = MOVETYPE_BOUNCE;
	setsize (self, '-6 -6 6', '6 6 6');
}

