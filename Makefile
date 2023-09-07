CC := cc
AR := ar
OBJDIR := obj
SRCDIR := src

SIGN := ldid -Sent.xml
STRIP := strip -rSx

PROGS := luac lua
LIBS := liblua.a

LIB_OBJS := $(OBJDIR)/lapi.o $(OBJDIR)/lauxlib.o $(OBJDIR)/lbaselib.o $(OBJDIR)/lcode.o $(OBJDIR)/lcorolib.o $(OBJDIR)/lctype.o $(OBJDIR)/ldblib.o $(OBJDIR)/ldebug.o $(OBJDIR)/ldo.o $(OBJDIR)/ldump.o $(OBJDIR)/lfunc.o $(OBJDIR)/lgc.o $(OBJDIR)/linit.o $(OBJDIR)/liolib.o $(OBJDIR)/llex.o $(OBJDIR)/lmathlib.o $(OBJDIR)/lmem.o $(OBJDIR)/loadlib.o $(OBJDIR)/lobject.o $(OBJDIR)/lopcodes.o $(OBJDIR)/loslib.o $(OBJDIR)/lparser.o $(OBJDIR)/lstate.o $(OBJDIR)/lstring.o $(OBJDIR)/lstrlib.o $(OBJDIR)/ltable.o $(OBJDIR)/ltablib.o $(OBJDIR)/ltm.o $(OBJDIR)/lundump.o $(OBJDIR)/lutf8lib.o $(OBJDIR)/lvm.o $(OBJDIR)/lzio.o

all: $(LIBS) $(PROGS)

luac: $(OBJDIR)/luac.o liblua.a
	$(CC) $(CFLAGS) -o $@ $(filter-out liblua.a,$^) -L. -llua
	$(STRIP) $@
	$(SIGN) $@

lua: $(OBJDIR)/lua.o liblua.a
	$(CC) $(CFLAGS) -o $@ $(filter-out liblua.a,$^) -L. -llua
	$(STRIP) $@
	$(SIGN) $@

liblua.a: $(LIB_OBJS)
	$(AR) -rcs $@ $^

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR):
	mkdir -p $@

clean:
	rm -rf $(OBJDIR)
	$(RM) $(PROGS)
	$(RM) liblua.a

