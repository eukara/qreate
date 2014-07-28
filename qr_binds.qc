// QREATE FOR QUAKE  by eukara //
// --------------------------- //
// This is released under GPL V2!
// Feel free to modify and to redristribute,
// but do so along with your modified code!

void qreate_selectspawn ();
void qreate_change_entityfw ();
void qreate_change_entitybw ();
void(entity client, string s, string b, string c) qreate_stuffcmd = #21;

void() Qreate_FOVInc =
{
	if(self.view_fov > 160)
		return;

	local string curfov;
	self.view_fov = self.view_fov + 2;
	curfov = ftos(self.view_fov);
	cvar_set("fov", curfov);
};

void() Qreate_FOVDec =
{
	if(self.view_fov < 10)
		return;

	local string curfov;
	self.view_fov = self.view_fov - 2;
	curfov = ftos(self.view_fov);
	cvar_set("fov", curfov);
};

void() Qreate_FOVReset =
{
	self.view_fov = 90;
	cvar_set("fov", "90");
};

float() qreate_altspawnmenu_input;
float() qreate_altspawnmenut_input;

void() qreate_altspawnmenu_switch;
void() qreate_altspawnmenut_switch;
void(void() monstername) qreate_spawn;
float() Qreate_Binds =
{
	if(qreate_altspawnmenu_input() == TRUE)
		return TRUE;
	else if(qreate_altspawnmenut_input() == TRUE)
		return TRUE;
	if (self.impulse == 50){
		qreate_selectspawn ();
		return TRUE;
	}
	if (self.impulse == 55)
	{
		if(self.reversem)
		qreate_change_entityfw ();
		else
		qreate_change_entitybw ();

		return TRUE;
	}
	if (self.impulse == 56)
	{
		if(self.reversem)
		qreate_change_toolfw ();
		else
		qreate_change_toolbw ();
		return TRUE;
	}

	if(self.impulse == 16){
		qreate_togglereverse();
		return TRUE;}
	if(self.impulse == 57){
		self.secfire = 1;
		return TRUE;}
	if(self.impulse == 58){
		self.secfire = 0;
		return TRUE;}
	if(self.impulse == 60){
		Qreate_FOVInc();
		return TRUE;}
	if(self.impulse == 61){
		Qreate_FOVDec();
		return TRUE;}
	if(self.impulse == 62){
		Qreate_FOVReset();
		return TRUE;}
	if(self.impulse == 78){
		qreate_altspawnmenu_switch();
		return TRUE;}
	if(self.impulse == 79){
		qreate_altspawnmenut_switch();
		return TRUE;}
	if(self.impulse == 80){
		qreate_serversidenoclip();
		return TRUE;}
	if(self.impulse == 81){
		qreate_spawn(qreate_hack_fakeplayer);
		return TRUE;}

	return FALSE;
};
