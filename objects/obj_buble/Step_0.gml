if(fazer_uma_vez)
{
	image_xscale = 0.3;
	image_yscale = 0.3;
	switch(direcao)
	{
	case 0: 
	hspeed += 0;
	vspeed += 8;
	}
	fazer_uma_vez = false;
}

tempo_vida +=1;

if(tempo_vida >=60)
{
	instance_destroy();
}