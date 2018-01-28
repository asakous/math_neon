#CFLAGS := -O2 -ggdb -mcpu=cortex-a7 -mfloat-abi=hard -mfpu=neon -ansi -std=gnu99 -pedantic
CCFLAGS := -Ofast -mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -ftree-vectorize
CXXFLAGS := -Ofast -mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -ftree-vectorize
WARNINGS := -Wall -Wextra -Wno-unused-parameter -Wmissing-prototypes
#ASSEMBLER := -Wa,-mimplicit-it=thumb

override CFLAGS += $(WARNINGS) $(ASSEMBLER)
LIBS := -lm

all: math_debug

libmathneon.a: math_acosf.o math_ldexpf.o math_powf.o  \
	math_asinf.o math_expf.o math_log10f.o math_runfast.o math_tanf.o \
	math_atan2f.o  math_fabsf.o math_logf.o math_sincosf.o math_tanhf.o \
	math_atanf.o math_floorf.o math_mat2.o math_sinf.o math_vec2.o \
	math_ceilf.o math_fmodf.o math_mat3.o math_sinfv.o math_vec3.o \
	math_cosf.o math_frexpf.o math_mat4.o math_sinhf.o math_vec4.o \
	math_coshf.o math_invsqrtf.o math_modf.o math_sqrtf.o

math_debug: math_debug.o libmathneon.a
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o:: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.a::
	$(AR) rcs $@ $^

clean:
	$(RM) -v math_debug *.o *.a
