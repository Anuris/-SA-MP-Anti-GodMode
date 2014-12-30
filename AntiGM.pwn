#include <a_samp>
#include <YSF>

#undef MAX_PLAYERS
const MAX_PLAYERS = 500;
new ShotsTotal[MAX_PLAYERS], ShotsDoneEffect[MAX_PLAYERS];

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid) //calling only with no cheat
{
	if(!IsPlayerPaused(playerid)) ShotsDoneEffect[playerid]++;
	else { ShotsTotal[playerid] = 0; ShotsDoneEffect[playerid] = 0; }
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) //calling ALWAYS and BEFORE OnPlayerTakeDamage
{
	if(hittype == BULLET_HIT_TYPE_PLAYER)
	{
		if(!IsPlayerPaused(hitid))
		{
			ShotsTotal[hitid]++;
			if(ShotsTotal[hitid] - ShotsDoneEffect[hitid] > 1)
			{
				Kick(hitid); //cheater
			}
		}
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	ShotsTotal[playerid] = 0;
	ShotsDoneEffect[playerid] = 0;
	return 1;
}
