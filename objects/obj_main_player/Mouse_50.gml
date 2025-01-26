
if (!is_main_player) exit;

if(!global.minigamePesca && !global.minigameSushi)
{
if (time_source_bomb) exit;
place_bomb();
}