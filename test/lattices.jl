using Test

import SymmetryReduceBZ.Lattices: check_reduced, get_recip_latvecs, minkowski_reduce,
  get_latparams, reduce_basis!, check_reduced

import SymmetryReduceBZ.Lattices
const lt = Lattices

@testset "lattices" begin
  @testset "get_latparams" begin
    latvecs = [1 0; 0 1]
    (lengths,angles) = get_latparams(latvecs)
    @test lengths == [1,1]
    @test angles == [pi/2, pi/2]

    latvecs = [1 0 0; 0 1 0; 0 0 1]
    (lengths,angles) = get_latparams(latvecs)
    @test lengths == [1,1,1]
    @test angles == [pi/2,pi/2,pi/2]

    @test_throws ArgumentError get_latparams([1 0])
  end

  @testset "check_reduced" begin
    latvecs = [1 0; 0 1]
    @test check_reduced(latvecs)

    latvecs = Array([1 0; 1 1]')
    @test check_reduced(latvecs) == false

    @test_throws ArgumentError check_reduced([1 0])
  end

  @testset "reduce_basis!" begin
    latvecs = [1 0; 0 1]
    @test_throws ArgumentError reduce_basis!(latvecs,1)
  end

  @testset "minkowski_reduce" begin
    # Test 1
    basis = [0.997559590093 0.327083693383 0.933708574257;
             0.246898693832 0.853865606330 0.534685117471;
             0.470554239317 0.503012665094 0.122191325919]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 2
    basis = [0.566824707611  0.230580598095  0.644795207463;
             0.062164441073  0.069592500822  0.444446612167;
             0.400346380548  0.334526702097  0.184730262940]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 3
    basis = [0.965915375496  0.913559885031  0.715882418258;
             0.907651021009  0.074522909849  0.841837872220;
             0.273128578139  0.826489413457  0.040093668849]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 4
    basis = [0.747927685471  0.288681880791  0.388321675735;
             0.519739433266  0.818689570053  0.616453247920;
             0.886262688190  0.399796817611  0.970347244023]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 5
    basis = [0.367390897375  0.660775660474  0.211656825515;
             0.084605591875  0.481734488916  0.429855314823;
             0.585439077728  0.797785266051  0.636905287099]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 6
    basis = [0.480636898755  0.799208677212  0.981910531646;
             0.395947716585  0.894180214969  0.229684979406;
             0.466195536761  0.321402105618  0.558040043342]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 7
    basis = [0.073754263634  0.919171496982  0.084716875229;
             0.101486421912  0.827727284628  0.362098268238;
             0.199341503544  0.463651019283  0.902481585522]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 8
    basis = [0.005355229278  0.995622271352  0.278599636291;
             0.047892267806  0.312276051592  0.364509680531;
             0.921399596836  0.679640515605  0.122704568964]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 9
    basis = [0.347081288518  0.164663213375  0.877540564643;
             0.239622809292  0.463104682188  0.998022806449;
             0.154273976230  0.627982335854  0.966889709417]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)

    # Test 10
    basis = [0.342243816073  0.811478344011  0.567158427035;
             0.643460104906  0.993952140553  0.710611242854;
             0.941907678956  0.015738060731  0.598940997350]
    rbasis=minkowski_reduce(basis)
    @test check_reduced(rbasis)
  end
  @testset "get_recip_latvecs" begin
    real_latvecs = [1 0; 0 1]
    convention = "ordinary"
    recip_latvecs = get_recip_latvecs(real_latvecs, convention)
    @test real_latvecs ≈ recip_latvecs

    convention = "angular"
    recip_latvecs = get_recip_latvecs(real_latvecs, convention)
    @test recip_latvecs ≈ [2π 0; 0 2π]

    @test_throws ArgumentError get_recip_latvecs(real_latvecs, "Ordinary")

  end

  @testset "genlat" begin
    a = 1
    b = 1
    @test_throws ArgumentError lt.genlat_RECI(a,b)

    a=1.
    b=1.
    θ=π/7.
    @test_throws ArgumentError lt.genlat_OBL(a,b,θ)
    @test_throws ArgumentError lt.genlat_OBL(a,b,π/2)

    a = 1
    c = 1
    @test_throws ArgumentError lt.genlat_TET(a,c)
    @test_throws ArgumentError lt.genlat_BCT(a,c)

    a = 1
    b = 1
    c = 2
    @test_throws ArgumentError lt.genlat_ORC(a,b,c)
    @test_throws ArgumentError lt.genlat_ORCF(a,c,b)
    @test_throws ArgumentError lt.genlat_ORCI(c,a,b)
    @test_throws ArgumentError lt.genlat_ORCC(c,b,a)


    a = 1
    @test_throws ArgumentError lt.genlat_HEX(a,a)

    a = 1
    θ=π/2
    @test_throws ArgumentError lt.genlat_RHL(a,θ)

    a = 1
    b = 2
    c = 3
    θ=π/5
    @test_throws ArgumentError lt.genlat_MCL(a,a,b,θ)
    @test_throws ArgumentError lt.genlat_MCL(a,b,c,π/2)

    @test_throws ArgumentError lt.genlat_MCLC(a,b,a,θ)
    @test_throws ArgumentError lt.genlat_MCL(a,b,c,π/2)

    α=π/3
    β=π/4
    γ=π/5
    @test_throws ArgumentError lt.genlat_TRI(a,c,c,α,β,γ)
    @test_throws ArgumentError lt.genlat_TRI(a,b,c,α,α,γ)
    @test_throws ArgumentError lt.genlat_TRI(a,b,c,β,β,γ)
  end
end
