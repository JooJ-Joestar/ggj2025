if(fazer_uma_vez)
{
	image_xscale = 0.3;
	image_yscale = 0.3;
	
	fazer_uma_vez = false;



switch(direcao)
	{
	case 0:  //up
	hspeed = 0;
	vspeed = -8;
	break;
	case 1: //up left
	hspeed = -8;
	vspeed = -8;
	break;
	case 2:  //left
	hspeed = -8;
	vspeed = 0;
	break;
	case 3: //left down
	hspeed = -8;
	vspeed = 8;
	break;
	case 4: //down
	hspeed = 0;
	vspeed = 8;
	break;
	case 5: //down right
	hspeed = 8;
	vspeed = 8;
	break;
	case 6: //right
	hspeed = 8;
	vspeed = 0;
	break;
	case 7: //up right
	hspeed = 8;
	vspeed = -8;
	break;
	}

}


tempo_vida +=1;

if(tempo_vida >=60)
{
	instance_destroy();
}