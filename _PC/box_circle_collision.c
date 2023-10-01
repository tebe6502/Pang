#include <stdint.h>

struct	SBox
{
	uint8_t	x, y;
	uint8_t	width, height;
};

struct	SCircle
{
	uint8_t	center_x, center_y;
	uint8_t	radius;
	uint8_t	offsets[];
};

bool	box_circle_collision(SBox* box, SCircle* circle)
{
	//	left edge
	if	((box->x + (box->width - 1)) < (circle->center_x - circle->radius))
		return false;

	//	right edge
	if	(box->x > (circle->center_x + circle->radius))
		return false;

	//	bottom edge
	if	((box->y + box->height - 1) < (circle->center_y - circle->radius))
		return false;

	//	top edge
	if	(box->y > (circle->center_y + circle->radius))
		return false;

	//	below center
	if	((box->y + height - 1) < circle->center_y)
	{
		//	third quarter
		if	((box->x + box->width) >= (circle->center_x - circle->offsets[box->y + box->height - 1 - (circle->center_y - circle->radius)]))
			return true;

		//	fourth quarter
		if	((circle->center_x + circle->offsets[box->y + box->height - 1 - (circle->center_y - circle->radius)]) <= box->x)
			return true;
	}

	//	above center
	if	((box->y + box->height - 1) >= circle->center_y)
	{
		//	second quarter
		if	((box->x + box->width) >= (circle->center_x - circle->offsets[circle->center_y + circle->radius - (box->y + box->height - 1)]))
			return true;

		//	first quarter
		if	((circle->center_x + circle->offsets[circle->center_y + circle->radius - (box->y + box->height - 1)]) <= box->x)
			return true;

		return true;
	}

	//	no collision
	return false;
}