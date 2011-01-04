// JeePU client example.
// $Id$

#define REMOTE 1    // set to 0 to use this sketch with a locally attached GLCD
#define NETGROUP 212
#define NODEID 1

#if REMOTE
#include <GLCD_proxy.h>
GLCD_proxy glcd (2); // ID of remote LCD host
#else
#include <GLCD_ST7565.h>
GLCD_ST7565 glcd;
#endif

#include <Ports.h>
#include <RF12.h>

static void refreshAndWait() {
    glcd.refresh();
    delay(2000);
}

void setup () {
#if REMOTE
    rf12_initialize(NODEID, RF12_868MHZ, NETGROUP);
#endif    
    glcd.begin();
    glcd.backLight(255);
}

void loop () {
    glcd.clear();
    glcd.drawString(30,24,"Hello World!");
    refreshAndWait();

    glcd.drawString(8,32,"Let's draw a line");
    refreshAndWait();
    
    glcd.drawLine(0,40,127,40,1);
    refreshAndWait();
    
    glcd.drawString(8,32,"And some black dots");
    refreshAndWait();
    
    for (int i=0;i<=21;i++)
        glcd.setPixel(i*6,40,0);
    refreshAndWait();
    
    glcd.clear();
    glcd.drawString(8,32,"Is that snow?");
    refreshAndWait();
    
    for (int i=0;i<1000;i++) {
        glcd.setPixel(random(LCDWIDTH)-1,random(LCDHEIGHT)-1,1);
        glcd.refresh();
        if (i%60==0)
            glcd.scroll(SCROLLDOWN,8);
    }
    refreshAndWait();
    
    glcd.clear();
    glcd.drawString(0,30,"Some");
    glcd.drawString(60,30,"text");
    refreshAndWait();
    
    glcd.drawString(27,27,"wonky");
    refreshAndWait();
    
    char *wonky="wonky";
    for (byte i=0;i<5;i++)
        glcd.drawChar(27+i*6,20-i,wonky[i]);
    refreshAndWait();

    glcd.clear();  
    glcd.drawString(8,32,"Rectangle?");
    refreshAndWait();
    
    glcd.drawRect(2,2,64,50,1);    
    refreshAndWait();
    
    for (byte x=1;x<20;x=x+3)
        glcd.fillRect(40+x,10+x,64-(2*x),50-(2*x),x&1);    
    refreshAndWait();
    
    glcd.clear();
    glcd.drawString(8,32,"circle?");
    refreshAndWait();
    
    glcd.drawCircle(63,31,31,1);    
    refreshAndWait();
    
    for (byte x=1;x<20;x=x+3)
        glcd.fillCircle(80-x,31,31-x,x&1);    
    refreshAndWait();
    
    glcd.clear();
    glcd.drawString(8,32,"Triangle?");
    refreshAndWait();
    
    glcd.drawTriangle(0,0,30,63,80,20,1);
    refreshAndWait();
    
    for (byte x=1;x<20;x=x+3)
        glcd.fillTriangle(40+x,x,50+x,63-x,120-x,20+x,x&1);
    refreshAndWait();    
}
