/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_12352588126616072024_3780659322_init();
    work_m_07577060021011869280_2832680351_init();
    work_m_12144575663178221792_0836637733_init();
    work_m_03186810358645642946_1756712915_init();
    work_m_09084917162869743130_2725559894_init();
    work_m_12498989396661693434_3027548060_init();
    work_m_08364609875989448123_1924288758_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_08364609875989448123_1924288758");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
