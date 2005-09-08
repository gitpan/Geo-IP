#ifdef __cplusplus
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "GeoIP.h"
#include "GeoIPCity.h"

#ifdef __cplusplus
}
#endif

MODULE = Geo::IP	PACKAGE = Geo::IP

PROTOTYPES: DISABLE

GeoIP *
new(CLASS,flags = 0)
	char * CLASS
	int flags
    CODE:
	RETVAL = GeoIP_new(flags);
    OUTPUT:
	RETVAL

GeoIP *
open_type(CLASS,type,flags = 0)
	char * CLASS
	int type
	int flags
    CODE:
	RETVAL = GeoIP_open_type(type,flags);
    OUTPUT:
	RETVAL

GeoIP *
open(CLASS,filename,flags = 0)
	char * CLASS
	char * filename
	int flags
    CODE:
	RETVAL = GeoIP_open(filename,flags);
    OUTPUT:
	RETVAL

int
id_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    CODE:
	RETVAL = GeoIP_id_by_addr(gi,addr);
    OUTPUT:
	RETVAL

int
id_by_name(gi, name)
	GeoIP *gi
	char * name
    CODE:
	RETVAL = GeoIP_id_by_name(gi,name);
    OUTPUT:
	RETVAL

char *
GeoIP_database_info (gi)
	GeoIP *gi
    PREINIT:
	int i = 0;  
    CODE:
	RETVAL = GeoIP_database_info(gi);
    OUTPUT:
	RETVAL

const char *
country_code_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    CODE:
	RETVAL = GeoIP_country_code_by_addr(gi,addr);
    OUTPUT:
	RETVAL

const char *
country_code_by_name(gi, name)
	GeoIP *gi
	char * name
    CODE:
	RETVAL = GeoIP_country_code_by_name(gi,name);
    OUTPUT:
	RETVAL

const char *
country_code3_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    CODE:
	RETVAL = GeoIP_country_code3_by_addr(gi,addr);
    OUTPUT:
	RETVAL

const char *
country_code3_by_name(gi, name)
	GeoIP *gi
	char * name
    CODE:
	RETVAL = GeoIP_country_code3_by_name(gi,name);
    OUTPUT:
	RETVAL

const char *
country_name_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    CODE:
	RETVAL = GeoIP_country_name_by_addr(gi,addr);
    OUTPUT:
	RETVAL

const char *
country_name_by_name(gi, name)
	GeoIP *gi
	char * name
    CODE:
	RETVAL = GeoIP_country_name_by_name(gi,name);
    OUTPUT:
	RETVAL

char *
org_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    CODE:
	RETVAL = GeoIP_org_by_addr(gi,addr);
    OUTPUT:
	RETVAL

char *
org_by_name(gi, name)
	GeoIP *gi
	char * name
    CODE:
	RETVAL = GeoIP_org_by_name(gi,name);
    OUTPUT:
	RETVAL

void
region_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    PREINIT:
	GeoIPRegion * gir;
    PPCODE:
	gir = GeoIP_region_by_addr(gi,addr);
        if (gir){
	  EXTEND(SP,2);
 	  PUSHs( sv_2mortal( newSVpv(gir->country_code, 2) ) );
	  PUSHs( sv_2mortal( newSVpv(gir->region, 2) ) );
	  GeoIPRegion_delete(gir);
        }

void
region_by_name(gi, name)
	GeoIP *gi
	char * name
    PREINIT:
	GeoIPRegion * gir;
    PPCODE:
	gir = GeoIP_region_by_name(gi,name);
        if (gir){
	  EXTEND(SP,2);
	  PUSHs( sv_2mortal( newSVpv(gir->country_code, 2) ) );
	  PUSHs( sv_2mortal( newSVpv(gir->region, 2) ) );
	  GeoIPRegion_delete(gir);
        }

GeoIPRecord *
record_by_addr(gi, addr)
	GeoIP *gi
	char * addr
    PREINIT:
	char * CLASS = "Geo::IP::Record";
    CODE:
	RETVAL = GeoIP_record_by_addr(gi,addr);
    OUTPUT:
	RETVAL

GeoIPRecord *
record_by_name(gi, addr)
	GeoIP *gi
	char * addr
    PREINIT:
	char * CLASS = "Geo::IP::Record";
    CODE:
	RETVAL = GeoIP_record_by_name(gi,addr);
    OUTPUT:
	RETVAL

void
DESTROY(gi)
	GeoIP *gi
    CODE:
	GeoIP_delete(gi);

MODULE = Geo::IP        PACKAGE = Geo::IP::Record

const char *
country_code(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->country_code;
    OUTPUT:
	RETVAL

const char *
country_code3(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->country_code3;
    OUTPUT:
	RETVAL

const char *
country_name(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->country_name;
    OUTPUT:
	RETVAL

const char *
region(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->region;
    OUTPUT:
	RETVAL

const char *
city(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->city;
    OUTPUT:
	RETVAL

const char *
postal_code(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = (const char *)gir->postal_code;
    OUTPUT:
	RETVAL

float
_latitude(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = gir->latitude;
    OUTPUT:
	RETVAL

float
_longitude(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = gir->longitude;
    OUTPUT:
	RETVAL

int
dma_code(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = gir->dma_code;
    OUTPUT:
	RETVAL

int
area_code(gir)
	GeoIPRecord *gir
    CODE:
	RETVAL = gir->area_code;
    OUTPUT:
	RETVAL

void
DESTROY(gir)
	GeoIPRecord *gir
    CODE:
	GeoIPRecord_delete(gir);
