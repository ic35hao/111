// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsdspi.h for the primary calling header

#include "Vsdspi__pch.h"
#include "Vsdspi__Syms.h"
#include "Vsdspi___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsdspi___024root___dump_triggers__stl(Vsdspi___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vsdspi___024root___eval_triggers__stl(Vsdspi___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsdspi__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsdspi___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vsdspi___024root___dump_triggers__stl(vlSelf);
    }
#endif
}