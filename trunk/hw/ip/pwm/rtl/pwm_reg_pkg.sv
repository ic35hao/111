// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package pwm_reg_pkg;

  // Param list
  parameter int NOutputs = 6;

  // Address width within the block
  parameter int BlockAw = 7;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////
  typedef struct packed {
    logic        q;
  } pwm_reg2hw_regen_reg_t;

  typedef struct packed {
    struct packed {
      logic [26:0] q;
    } clk_div;
    struct packed {
      logic [3:0]  q;
    } dc_resn;
    struct packed {
      logic        q;
    } cntr_en;
  } pwm_reg2hw_cfg_reg_t;

  typedef struct packed {
    logic        q;
  } pwm_reg2hw_pwm_en_mreg_t;

  typedef struct packed {
    logic        q;
  } pwm_reg2hw_invert_mreg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } phase_delay;
    struct packed {
      logic        q;
    } htbt_en;
    struct packed {
      logic        q;
    } blink_en;
  } pwm_reg2hw_pwm_param_mreg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } a;
    struct packed {
      logic [15:0] q;
    } b;
  } pwm_reg2hw_duty_cycle_mreg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } x;
    struct packed {
      logic [15:0] q;
    } y;
  } pwm_reg2hw_blink_param_mreg_t;



  ///////////////////////////////////////
  // Register to internal design logic //
  ///////////////////////////////////////
  typedef struct packed {
    pwm_reg2hw_regen_reg_t regen; // [536:536]
    pwm_reg2hw_cfg_reg_t cfg; // [535:504]
    pwm_reg2hw_pwm_en_mreg_t [5:0] pwm_en; // [503:498]
    pwm_reg2hw_invert_mreg_t [5:0] invert; // [497:492]
    pwm_reg2hw_pwm_param_mreg_t [5:0] pwm_param; // [491:384]
    pwm_reg2hw_duty_cycle_mreg_t [5:0] duty_cycle; // [383:192]
    pwm_reg2hw_blink_param_mreg_t [5:0] blink_param; // [191:0]
  } pwm_reg2hw_t;

  ///////////////////////////////////////
  // Internal design logic to register //
  ///////////////////////////////////////

  // Register Address
  parameter logic [BlockAw-1:0] PWM_REGEN_OFFSET = 7'h 0;
  parameter logic [BlockAw-1:0] PWM_CFG_OFFSET = 7'h 4;
  parameter logic [BlockAw-1:0] PWM_PWM_EN_OFFSET = 7'h 8;
  parameter logic [BlockAw-1:0] PWM_INVERT_OFFSET = 7'h c;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_0_OFFSET = 7'h 10;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_1_OFFSET = 7'h 14;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_2_OFFSET = 7'h 18;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_3_OFFSET = 7'h 1c;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_4_OFFSET = 7'h 20;
  parameter logic [BlockAw-1:0] PWM_PWM_PARAM_5_OFFSET = 7'h 24;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_0_OFFSET = 7'h 28;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_1_OFFSET = 7'h 2c;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_2_OFFSET = 7'h 30;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_3_OFFSET = 7'h 34;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_4_OFFSET = 7'h 38;
  parameter logic [BlockAw-1:0] PWM_DUTY_CYCLE_5_OFFSET = 7'h 3c;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_0_OFFSET = 7'h 40;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_1_OFFSET = 7'h 44;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_2_OFFSET = 7'h 48;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_3_OFFSET = 7'h 4c;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_4_OFFSET = 7'h 50;
  parameter logic [BlockAw-1:0] PWM_BLINK_PARAM_5_OFFSET = 7'h 54;

  // Register Index
  typedef enum int {
    PWM_REGEN,
    PWM_CFG,
    PWM_PWM_EN,
    PWM_INVERT,
    PWM_PWM_PARAM_0,
    PWM_PWM_PARAM_1,
    PWM_PWM_PARAM_2,
    PWM_PWM_PARAM_3,
    PWM_PWM_PARAM_4,
    PWM_PWM_PARAM_5,
    PWM_DUTY_CYCLE_0,
    PWM_DUTY_CYCLE_1,
    PWM_DUTY_CYCLE_2,
    PWM_DUTY_CYCLE_3,
    PWM_DUTY_CYCLE_4,
    PWM_DUTY_CYCLE_5,
    PWM_BLINK_PARAM_0,
    PWM_BLINK_PARAM_1,
    PWM_BLINK_PARAM_2,
    PWM_BLINK_PARAM_3,
    PWM_BLINK_PARAM_4,
    PWM_BLINK_PARAM_5
  } pwm_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] PWM_PERMIT [22] = '{
    4'b 0001, // index[ 0] PWM_REGEN
    4'b 1111, // index[ 1] PWM_CFG
    4'b 0001, // index[ 2] PWM_PWM_EN
    4'b 0001, // index[ 3] PWM_INVERT
    4'b 1111, // index[ 4] PWM_PWM_PARAM_0
    4'b 1111, // index[ 5] PWM_PWM_PARAM_1
    4'b 1111, // index[ 6] PWM_PWM_PARAM_2
    4'b 1111, // index[ 7] PWM_PWM_PARAM_3
    4'b 1111, // index[ 8] PWM_PWM_PARAM_4
    4'b 1111, // index[ 9] PWM_PWM_PARAM_5
    4'b 1111, // index[10] PWM_DUTY_CYCLE_0
    4'b 1111, // index[11] PWM_DUTY_CYCLE_1
    4'b 1111, // index[12] PWM_DUTY_CYCLE_2
    4'b 1111, // index[13] PWM_DUTY_CYCLE_3
    4'b 1111, // index[14] PWM_DUTY_CYCLE_4
    4'b 1111, // index[15] PWM_DUTY_CYCLE_5
    4'b 1111, // index[16] PWM_BLINK_PARAM_0
    4'b 1111, // index[17] PWM_BLINK_PARAM_1
    4'b 1111, // index[18] PWM_BLINK_PARAM_2
    4'b 1111, // index[19] PWM_BLINK_PARAM_3
    4'b 1111, // index[20] PWM_BLINK_PARAM_4
    4'b 1111  // index[21] PWM_BLINK_PARAM_5
  };
endpackage
