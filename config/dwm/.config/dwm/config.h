#include "gaplessgrid.c"
#include "selfrestart.c"
#include "zoomswap.c"
#include "moveresize.c"

/* mbp-mappings */
#define XF86AudioMute			0x1008ffa1
#define XF86AudioLowerVolume	        0x1008ffa2
#define XF86AudioRaiseVolume	        0x1008ffa3

static const char *fonts[] = {
	"fixed:pixelsize=9",
	"Siji:pixelsize=9"
};

static const unsigned int borderpx 			= 1;	/* border pixel of windows */
static const unsigned int snap 				= 1;	/* snap pixel */
static const unsigned int tagpadding 		        = 1;	
static const unsigned int tagspacing 		        = 1;	
static const unsigned int gappx				= 0;	/* gap pixel between windows */
static const unsigned int systraypinning 	        = 0;	/* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing 	        = 2;	/* systray spacing */
static const int systraypinningfailfirst 	        = 1;	/* 1: if pinning fails, display systray on the first monitor, 0: display systray on the last monitor*/
static const int showsystray 				= 1;	/* 0 means no systray */
static const int showbar 			        = 1;	/* 0 means no bar */
static const int topbar 				= 1;	/* 0 means bottom bar */
static const char dmenufont[]                           = "tewi:size=8";
static const char normbordercolor[]                     = "#000000";
static const char normbgcolor[]                         = "#000000";
static const char normfgcolor[]                         = "#b2b2b2";
static const char selbordercolor[]                      = "#000000";
static const char selbgcolor[]                          = "#cc0000";
static const char selfgcolor[]                          = "#000000";

#define NUMCOLORS 9
static const char colors[NUMCOLORS][MAXCOLORS][9] = {
	// border    foreground	background
	{ "#151515", "#b2b2b2", "#000000" }, // 0 = normal
	{ "#151515", "#000000", "#cc0000" }, // 1 = selected
	{ "#151515", "#000000", "#b2b2b2" }, // 2 = red / urgent
	{ "#151515", "#b2b2b2", "#404040" }, // 3 = green / occupied
	{ "#151515", "#686868", "#000000" }, // 4 = yellow
	{ "#151515", "#8e8e8e", "#000000" }, // 5 = blue
	{ "#151515", "#676767", "#000000" }, // 6 = cyan
	{ "#151515", "#da2121", "#000000" }, // 7 = magenta
	{ "#151515", "#888888", "#000000" }, // 8 = grey
};

/* tagging */
static const char *tags[] = {
		"web",
		"vim",
		"doc",
		"med",
		"pen",
		"sys",
                "lab",
                "app",
                "misc"
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class			instance	title		tags mask	isfloating		monitor */
	{ "Gimp",			NULL,		NULL,		1 << 8,	        0,			-1 },
	{ "Firefox",		        NULL,		NULL,		1 << 0,		0,			-1 },
	{ "Chromium-browser-chromium",	NULL,		NULL,		1 << 0,		0,			-1 },
	{ "Nitrogen",		        NULL,		NULL,		0,		1,			-1 },
	{ "Lxappearance",	        NULL,		NULL,		0,		1,			-1 },
	{ "Wireshark",			NULL,		NULL,		0,		1,			-1 },
};

/* layout(s) */
static const float mfact 		= 0.55;	/* factor of master area size [0.05..0.95] */
static const int nmaster 		= 1;	/* number of clients in master area */
static const int resizehints 	        = 0;	/* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "\ue002",      tile },    /* first entry is default */
	{ "\ue006",      NULL },    /* no layout function means floating behavior */
	{ "\ue000",      monocle },
	{ "\ue003",      htile },
	{ "\ue00a",      gaplessgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] 	        = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]           = { "dmenu_run", "-b", "-m", dmenumon, "-i", "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *dmenuext[] 		= { "dmenu_extended_run", NULL };
static const char *termcmd[] 		= { "st", NULL };
static const char *screenshot[] 	= { "scrot", NULL};


static Key keys[] = {
	/* modifier				        key						function			argument */
	{ MODKEY,					XK_d,						spawn,				{.v = dmenucmd } },
	{ MODKEY,					XK_s,						spawn,				{.v = dmenuext } },
	{ MODKEY,					XK_Return,					spawn,				{.v = termcmd } },
	{ MODKEY|ShiftMask,				XK_b,						togglebar,			{0} },
	{ MODKEY,					XK_Right,					focusstack,			{.i = +1 } },
	{ MODKEY,					XK_Left,					focusstack,			{.i = -1 } },
	{ MODKEY,					XK_i,						incnmaster,			{.i = +1 } },
	{ MODKEY,					XK_d,						incnmaster,			{.i = -1 } },
	{ MODKEY|ShiftMask,				XK_Left,					setmfact,			{.f = -0.05} },
	{ MODKEY|ShiftMask,				XK_Right,					setmfact,			{.f = +0.05} },
	{ MODKEY|ShiftMask,				XK_Up,						setcfact,			{.f = +0.25} },
	{ MODKEY|ShiftMask,				XK_Down,					setcfact,			{.f = -0.25} },
	{ MODKEY|ShiftMask,				XK_o,						setcfact,			{.f =  0.00} },
	{ MODKEY,					XK_Down,					pushdown,			{0} },
        { MODKEY,					XK_Up,						pushup,				{0} },
	{ MODKEY|ShiftMask,				XK_Return,					zoom,				{0} },
	{ MODKEY,					XK_Tab,						view,				{0} },
	{ MODKEY|ShiftMask,				XK_q,						killclient,			{0} },
	{ MODKEY,					XK_t,						setlayout,			{.v = &layouts[0]} },
	{ MODKEY,					XK_f,						setlayout,			{.v = &layouts[1]} },
	{ MODKEY,					XK_m,						setlayout,			{.v = &layouts[2]} },
	{ MODKEY,					XK_b,						setlayout,			{.v = &layouts[3]} },
	{ MODKEY,					XK_g,						setlayout,			{.v = &layouts[4]} },
	{ MODKEY,					XK_space,					setlayout,			{0} },
        { MODKEY,					XK_u,						togglefullscreen,       	{0} },
	{ MODKEY|ShiftMask,				XK_space,					togglefloating,	        	{0} },
	{ MODKEY,					XK_0,						view,				{.ui = ~0 } },
	{ MODKEY|ShiftMask,				XK_0,						tag,				{.ui = ~0 } },
	{ MODKEY,					XK_comma,					focusmon,			{.i = -1 } },
	{ MODKEY,					XK_period,					focusmon,			{.i = +1 } },
	{ MODKEY|ShiftMask,				XK_comma,					tagmon,				{.i = -1 } },
	{ MODKEY|ShiftMask,				XK_period,					tagmon,				{.i = +1 } },
	{ Mod4Mask,					XK_Up,						moveresize,			{.v = "0x -25y 0w 0h"} },
	{ Mod4Mask,					XK_Down,					moveresize,			{.v = "0x 25y 0w 0h"} },
	{ Mod4Mask,					XK_Left,					moveresize,			{.v = "-25x 0y 0w 0h"} },
	{ Mod4Mask,					XK_Right,					moveresize,			{.v = "25x 0y 0w 0h"} },
	{ Mod4Mask|ShiftMask,			        XK_Up,						moveresize,			{.v = "0x 0y 0w -25h"} },
	{ Mod4Mask|ShiftMask,			        XK_Down,					moveresize,			{.v = "0x 0y 0w 25h"} },
	{ Mod4Mask|ShiftMask,			        XK_Left,					moveresize,			{.v = "0x 0y -25w 0h"} },
	{ Mod4Mask|ShiftMask,			        XK_Right,					moveresize,			{.v = "0x 0y 25w 0h"} },
	TAGKEYS(					XK_1,						0)
	TAGKEYS(					XK_2,						1)
	TAGKEYS(					XK_3,						2)
	TAGKEYS(					XK_4,						3)
	TAGKEYS(					XK_5,						4)
	TAGKEYS(					XK_6,						5)
	TAGKEYS(					XK_7,						6)
	TAGKEYS(					XK_8,						7)
	TAGKEYS(					XK_9,						8)
	{ MODKEY|ShiftMask,				XK_Escape,					quit,				{0} },
	{ MODKEY|ShiftMask,				XK_r,						self_restart,		        {0} },
        { 0,						XK_Print,					spawn,				{.v = screenshot } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click					event mask		button			function			argument */
	{ ClkLtSymbol,					0,			Button1,		setlayout,			{0} },
	{ ClkLtSymbol,					0,			Button3,		setlayout,			{.v = &layouts[2]} },
	{ ClkStatusText,				0,			Button2,		spawn,				{.v = termcmd } },
	{ ClkClientWin,					MODKEY,		        Button1,		movemouse,			{0} },
	{ ClkClientWin,					MODKEY,		        Button2,		togglefloating,  		{0} },
	{ ClkClientWin,					MODKEY,		        Button3,		resizemouse,	         	{0} },
	{ ClkTagBar,					0,			Button1,		view,				{0} },
	{ ClkTagBar,					0,			Button3,		toggleview,			{0} },
	{ ClkTagBar,					MODKEY,	        	Button1,		tag,				{0} },
	{ ClkTagBar,					MODKEY,	        	Button3,		toggletag,			{0} },
};
