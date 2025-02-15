// 頂点シェーダーへの入力頂点構造体
struct VSInput
{
    float4 pos : POSITION;
    float3 color : COLOR; // 頂点からカラーのデータを引っ張ってくる
};

// 頂点シェーダーの出力
struct VSOutput
{
    float4 pos : SV_POSITION;
    float3 color : COLOR; // カラーの情報も出力する
};

// 頂点シェーダー
// 1. 引数は変換前の頂点情報
// 2. 戻り値は変換後の頂点情報
VSOutput VSMain(VSInput In)
{
    VSOutput vsOut = (VSOutput)0;
    vsOut.pos = In.pos;
    vsOut.color = In.color; // カラーの情報を出力する
    return vsOut;
}

// ピクセルシェーダー
//戻り値は色
float4 PSMain(VSOutput vsOut) : SV_Target0
{
    // 赤色を出力している
    //return float4(1.0f, 0.0f , 0.0f, 1.0f);

    // step-1 三角形を青色にする
    //return float4(0.0, 0.0, 1.0, 1.0);
    // step-2 三角形を緑色にする
    //return float4(0.0, 1.0, 0.0, 1.0);
    // step-3 三角形を黄色にする
    //return float4(1.0, 1.0, 0, 1.0);
    // step-4 頂点シェーダーから受け取ったカラーを出力する
    //頂点データが補完されて渡される. 補完はラスタライズで行っている
    //ラスタライズの仕事は塗りつぶすピクセルの決定と補完
    return float4(vsOut.color, 1.0f);
}
