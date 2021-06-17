// 頂点シェーダーへの入力頂点構造体
struct VSInput
{
    //float4: x, y, z, wのベクトル型
    // 
    //POSITION: セマンティクスの型
    //セマンティクスとは？ → データの使い方を指定するもの. どのデータを頂点データで使用するかをここで指定する
    //頂点データが持つデータでよく使われるのに、「座標、法線、接ベクトル、カラー、uv座標、スキンウェイト、スキンインデックス」がある
    //スキンウェイト .. スキンアニメーション時に使用. 関連のあるボーンへの影響度のこと
    //スキンインデックス .. スキンアニメーション時に使用. 関連のあるボーンの番号のこと
    float4 pos : POSITION;

    /*
    入力セマンティクス
    POSITION: オブジェクト座標
    COLOR: 頂点カラー
    NORMAL: 法線ベクトル
    TANGENT: 接ベクトル
    TEXCOORD: uv座標
    BLENDWEIGHT: スキンウェイト
    BLENDINDICES: スキンインデックス
    */
};

/* セマンティクスはなぜあるか?
* 
頂点データが頂点数だけ並んだものを頂点バッファーという
struct Vertex
{
    float position[4];
    float normal[3];
    float color[4];
    float uv[2];
}

//頂点バッファー
Vertex vertexBuffer[6];

------
Shaderが下のようになっているとき

struct VSInput
{
    fixed4 hoge : POSITION;
}

//出力構造体は省略

VSOutput VSMain(VSInput IN)
{
    VSOutput vsOut = (VSOutput)0;
    vsOut.pos = IN.hoge;        //hogeには何のデータが入るか → セマンティクスから positionが参照される
}
*/

//コラム
/*
c++側でも、頂点データの構造を伝える(指定する)必要がある
→ 「頂点レイアウト」の定義を用いる

    main.cpの以下のコード
    // 頂点レイアウトを定義する
    D3D12_INPUT_ELEMENT_DESC inputElementDescs[] =
    {
        { "POSITION", 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, 0, D3D12_INPUT_CLASSIFICATION_PER_VERTEX_DATA, 0 },
    };

    セマンティクス名のPOSITIONをここで指定していることがポイント
*/

// 頂点シェーダーの出力
//出力頂点構造体
struct VSOutput
{
    //出力データとして座標を扱う場合は SV_POSITIONを指定する必要あり 
    float4 pos : SV_POSITION;
};

// 頂点シェーダー
// 1. 引数は変換前の頂点情報
// 2. 戻り値は変換後の頂点情報
VSOutput VSMain(VSInput In)
{
    VSOutput vsOut = (VSOutput)0;

    // step-1 入力された頂点座標を出力データに代入する]
    vsOut.pos = In.pos;

    // step-2 入力された頂点座標を2倍に拡大する
    //vsOut.pos.x *= 2.0f;
    //vsOut.pos.y *= 2.0f;
    //vsOut.pos.xy *= 2.0f;

    // step-3 入力されたX座標を1.5倍、Y座標を0.5倍にして出力
    vsOut.pos.x *= 1.5f;
    vsOut.pos.y *= 0.5f;

    return vsOut;
}

// ピクセルシェーダー
float4 PSMain(VSOutput vsOut) : SV_Target0
{
    return float4(1.0f, 0.0f, 0.0f, 1.0f);
}