Given yesterdays and todays tables flag updates inserts and deletes

Proc compare will give more detail.

github
https://tinyurl.com/ybjw86ql
https://github.com/rogerjdeangelis/utl-given-yesterdays-and-todays-tables-flag-updates-inserts-and-deletes

SAS Forum
https://tinyurl.com/yblzdnne
https://communities.sas.com/t5/SAS-Programming/Change-data-capture-How-do-I-track-changing-data/m-p/514045

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


INPUT
=====

 WORK.YESTERDAY total obs=3

  NAME     DEPT       DATE

  John    Sales      01JAN2018
  Mary    Finance    01JAN2018
  Jake    Finance    01JAN2018


 WORK.TODAY total obs=2

  NAME     DEPT      DATE

  John    Sales     01JAN2018
  Mary    Acctng    01JAN2018


EXAMPLE OUTPUT
--------------

Transaction data set obs=3

NAME     DEPT        DATE       __SPLIT    __TYPE

Jake    Finance    02JAN2018      OLD      DELETE
John    Sales      01JAN2018      NEW      UPDATE
Mary    Acctng     01JAN2018      NEW      UPDATE

This transaction dataset can be used to create todays dataset from yeaterdays.
So if you lose todays you can run this to recreate it.

Sldo if you do not want to keep minimize space.


PROCESS
=======

%utl_delta
    (
     uinmem1 =yesterday,       /* Last Months Data */
     uinmem2 =today,           /* Current Month Data */
     uinkey  =name,            /* primary unique key both tables */
     uotmem1 =repdelta,        /* delta tble for RDBMS update */
     uotmem2= repsame
    );

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data today;
   input name $ dept $ date date9.;
   format date date9.;
cards4;
John Sales 01JAN2018
Mary Acctng 01JAN2018
;;;;
run;quit;


data yesterday;
   input name $ dept $ date date9.;
   format date date9.;
cards4;
John Sales 02JAN2018
Mary Finance 02JAN2018
Jake Finance 02JAN2018
;;;;
run;quit;

