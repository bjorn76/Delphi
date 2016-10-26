/******************************************************************/
/*                                                                */
/*     Copyright (C) QUINN-CURTIS, Inc. 1992- 1998                */
/*                                                                */
/******************************************************************/
/*                                                                */
/*   Filename :   Polysurf.h                                         */
/*   Author   :   QC                                              */
/*   Revision :   3.0                                             */
/*   Date     :   August 15, 1998                                 */
/*                                                                */
/******************************************************************/


#ifndef POLYSURF
#define POLYSURF
#pragma pack(push, 8)


#define X_AXIS  0
#define Y_AXIS  1
#define Z_AXIS  2



#define PS_SQUARE   0
#define PS_TRIANGLE 1

#define CONTOUR_LABEL_OUT   0
#define CONTOUR_LABEL_IN    1


typedef struct {
		 int x,y, z, v;
	       } pnt3Dtype;

typedef struct {
		 realtype x,y,z, v;
	       } point3Dtype;


typedef struct {
		 int numpoints;
		 point3Dtype *pointlist;
		} pointlisttype;

typedef struct { unsigned char surfacecolors;
		 unsigned char bordercolor;
		 unsigned char numedges;
		 int  *edgelist;
 		 point3Dtype PlaneEqn;
	       } polygonentrytype;

typedef struct {
		 unsigned numpolygons;
		 unsigned usedpolygons;
		 unsigned tablelength;
		 int tableindex;
		 polygonentrytype  *polygonentrys;
		 int  *polygonedgelist;
	       } polygonlisttype;

typedef struct {
		 pointlisttype surfacepointlist;
		 polygonlisttype surfacepolygonlist;
		 int  *adjpolygonlist;

	       } polysurfacetype;


polysurfacetype * OpenPolySurface(
			  int numpoints,
			  int numpolygons,
			  int pntsperpoly);
void AllocAdjacentPolygonList(polysurfacetype *psf);
void FreeAdjacentPolygonList(polysurfacetype *psf);
void AddAdjacentPolyList(polysurfacetype *psf, int tri, int *adjlist);
void ClosePolySurface(polysurfacetype *psf);
void SetPolySurfacePoints(polysurfacetype *psf,
			  point3Dtype *points,
			  int startindex,
			  int numpoints);
void SetOnePolySurfacePoint(polysurfacetype *psf,
			  int index,
			  point3Dtype *points);
void GetOnePolySurfacePoint(polysurfacetype *psf,
			  int index,
			  point3Dtype *points);
int AddPolySurfacePolygon(polysurfacetype *psf,
			   int polyindex,
			   int *pointindices,
			  int numedges,
			  int outsidecolor,
			  int bordercolor);
void SetPolySurfaceColors(polysurfacetype *psf,
			   int polyindex,
			  int outsidecolor,
			  int bordercolor);

int GetPolySurfacePolygon(polysurfacetype *psf,
			    int polyindex,
			    point3Dtype *points,
			    int *numedges,
			    int *outsidecolor,
			    int *bordercolor);
int GPSPolygon(polysurfacetype *psf,
			    int polyindex,
			    point3Dtype *points,
			    int *numedges);
void  CreateRGAdjacentPolygonList(polysurfacetype *psf, int nRows,
								        int nCols);
polysurfacetype *ConvertRG2PS(point3Dtype *grid,
			      int rows,
			      int columns,
			      int gridtype);
polysurfacetype *   CreatePolySurfaceFunction( int columns, int rows,
		    realtype x1,
		    realtype x2,
		    realtype y1,
		    realtype y2,
		    realtype (*surfproc)(realtype, realtype));
realtype GetPSPMean(polysurfacetype *psf,
		    int polyindex,
		    int coord);

int GetPSNumPolygons(polysurfacetype *psf);
int GetPSNumPoints(polysurfacetype *psf);
int QCDelaunayTriangles(polysurfacetype *psf,
		       int *pntlisti,
		       int listn,
		       int *numbertriangles,
		       int keepadjtrilist);


#pragma pack(pop)

#endif

