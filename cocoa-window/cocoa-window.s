.global _start
.align 2

_start:
    /* Create an app */

    // app (X19) = [NSApplication sharedApplication]
    adr X0, _sel_sharedApplication
    bl _sel_getUid
    mov X19, X0

    adr X0, _cls_NSApplication
    bl _objc_getClass

    mov X1, X19
    bl _objc_msgSend
    mov X19, X0

    // [app setActivationPolicy:NSApplicationActivationPolicyRegular]
    // NSApplicationActivationPolicyRegular = 0
    adr X0, _sel_setActivationPolicy
    bl _sel_getUid
    mov X1, X0

    mov X0, X19
    mov X2, XZR
    bl _objc_msgSend

    // window (X20) = [NSWindow alloc]
    adr X0, _sel_alloc
    bl _sel_getUid
    mov X20, X0

    adr X0, _cls_NSWindow
    bl _objc_getClass

    mov X1, X20
    bl _objc_msgSend
    mov X20, X0

    // [window
    //     initWithContentRect:rect
    //     styleMask:NSWindowStyleMaskTitled|NSWindowStyleMaskClosable
    //     backing:NSBackingStoreBuffered
    //     defer:NO]
    // styleMask = 0x7
    // NSBackingStoreBuffered = 0x2
    adr X0, _sel_initWithContentRect_styleMask_backing_defer
    bl _sel_getUid
    mov X1, X0
    mov X0, X20
    mov X2, #0x7
    mov X3, #0x2
    mov X4, XZR

    // Load window rectange
    adrp X5, _window_rect@PAGE
    add X5, X5, _window_rect@PAGEOFF
    ldr d0, [X5]
    ldr d1, [X5, #8]
    ldr d2, [X5, #16]
    ldr d3, [X5, #24]

    bl _objc_msgSend

    // [window makeKeyAndOrderFront:nil]
    adr X0, _sel_makeKeyAndOrderFront
    bl _sel_getUid
    mov X1, X0

    mov X0, X20
    mov X2, XZR
    bl _objc_msgSend

    // [app activateIgnoringOtherApps:YES]
    adr X0, _sel_activateIgnoringOtherApps
    bl _sel_getUid
    mov X1, X0

    mov X0, X19
    mov X2, #0x1
    bl _objc_msgSend

    // [app run]
    adr X0, _sel_run
    bl _sel_getUid
    mov X1, X0

    mov X0, X19
    bl _objc_msgSend

    /* Exit */

    mov X0, #0           // rval
    mov X16, #1          // void exit(int rval)
    svc #0x80

.align 2
_cls_NSApplication: .ascii "NSApplication\0"
.align 2
_sel_sharedApplication: .ascii "sharedApplication\0"
.align 2
_sel_setActivationPolicy: .ascii "setActivationPolicy:\0"
.align 2
_cls_NSWindow: .ascii "NSWindow\0"
.align 2
_sel_alloc: .ascii "alloc\0"
.align 2
_sel_initWithContentRect_styleMask_backing_defer: .ascii "initWithContentRect:styleMask:backing:defer:\0"
.align 2
_sel_makeKeyAndOrderFront: .ascii "makeKeyAndOrderFront:\0"
.align 2
_sel_activateIgnoringOtherApps: .ascii "activateIgnoringOtherApps:\0"
.align 2
_sel_run: .ascii "run\0"
.align 2
_window_rect: .double 0.0
              .double 0.0
              .double 800.0
              .double 600.0
