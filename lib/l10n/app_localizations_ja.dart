// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get questionFormTitle => '患者データ';

  @override
  String get nextButton => '次へ';

  @override
  String get backButton => '戻る';

  @override
  String get questionInstructionTitle => 'はじめに';

  @override
  String get questionInstructionSubtitle => 'ご使用前に説明をお読みください。';

  @override
  String get questionSexTitle => '性別';

  @override
  String get questionSexSubtitle => '性別を選んでください。';

  @override
  String get questionAgeTitle => '年齢 [歳]';

  @override
  String get questionAgeSubtitle => '年齢を入力して、次へを押してください。';

  @override
  String get questionHeightTitle => '身長 [cm]';

  @override
  String get questionHeightSubtitle => '身長 [cm]を入力して、次へを押してください';

  @override
  String get questionWeightTitle => '体重 [kg]';

  @override
  String get questionWeightSubtitle => '体重 [kg]を入力して、次へを押してください';

  @override
  String get questionAlbTitle => 'アルブミン値 [g/dl]';

  @override
  String get questionAlbSubtitle => 'アルブミン値 [g/dl]を入力して、次へを押してください';

  @override
  String get questionActivityTitle => 'ADL';

  @override
  String get questionActivitySubtitle => '独歩, 車いす, 寝たきりから選んでください。';

  @override
  String get questionCHFTitle => 'うっ血性心不全';

  @override
  String get questionCHFSubtitle => 'ありには、心不全入院歴あり・有症状の場合及びエコーでの心機能低下を含む。';

  @override
  String get questionCADTitle => '冠動脈疾患';

  @override
  String get questionCADSubtitle => 'ありには、心筋梗塞、狭心症の既往・PCI歴あり・CABG歴ありを含む。';

  @override
  String get questionCVDTitle => '脳血管障害';

  @override
  String get questionCVDSubtitle => 'ありには、脳梗塞・一過性脳虚血発作を含む。';

  @override
  String get questionCKDTitle => '慢性腎臓病\n (eGFR*: mL/min/1.73m²)';

  @override
  String get questionCKDSubtitle => '正常: 60以上, G3: 30-59, G4: 15-29, G5: 15以下, G5D: 透析\n *eGFR: 推定糸球体濾過量';

  @override
  String get questionMalignantTitle => '悪性新生物';

  @override
  String get questionMalignantSubtitle => 'なし, 既往歴あり, 治療中から選んでください。';

  @override
  String get questionAILesionTitle => '大動脈腸骨動脈領域病変';

  @override
  String get questionAILesionSubtitle => '';

  @override
  String get questionFPLesionTitle => '大腿膝窩領域病変';

  @override
  String get questionFPLesionSubtitle => '';

  @override
  String get questionBKLesionTitle => '膝下膝窩以下末梢領域病変';

  @override
  String get questionBKLesionSubtitle => '';

  @override
  String get questionUrgentTitle => '緊急血行再建の適応';

  @override
  String get questionUrgentSubtitle => 'あり：緊急手術, なし：待機手術';

  @override
  String get questionFeverTitle => '発熱';

  @override
  String get questionFeverSubtitle => 'あり: 体温38℃以上';

  @override
  String get questionAbnormalWBCTitle => '白血球数異常';

  @override
  String get questionAbnormalWBCSubtitle => 'あり: 8000 [/µl]以上';

  @override
  String get questionLocalInfectionTitle => '局所感染';

  @override
  String get questionLocalInfectionSubtitle => 'あり：膿瘍あり、もしくは次から二つ [発熱・発赤・リンパ管炎・リンパ節腫脹・疼痛]';

  @override
  String get questionDLTitle => '脂質異常症';

  @override
  String get questionDLSubtitle => 'はい: LDL-C > 140 [mg/dl]';

  @override
  String get questionSmokingTitle => '喫煙';

  @override
  String get questionSmokingSubtitle => 'はい：喫煙中・喫煙歴あり';

  @override
  String get questionContraTitle => '対側動脈病変';

  @override
  String get questionContraSubtitle => 'ありには治療後も含む。';

  @override
  String get questionOtherLesionTitle => 'その他血管病変';

  @override
  String get questionOtherLesionSubtitle => '対側病変は含まない。';

  @override
  String get questionRutherfordTitle => 'ラザフォード分類';

  @override
  String get questionRutherfordSubtitle => 'class 4, 5, 6から選んでください。';

  @override
  String get questionSummaryTitle => '患者データ一覧';

  @override
  String get questionSummarySubtitle => '確認してください。';

  @override
  String get yes => 'あり';

  @override
  String get no => 'なし';

  @override
  String get male => '男性';

  @override
  String get female => '女性';

  @override
  String get ambulatory => '独歩';

  @override
  String get wheelchair => '車いす';

  @override
  String get immobile => '寝たきり';

  @override
  String get normal => '正常';

  @override
  String get g3 => 'G3';

  @override
  String get g4 => 'G4';

  @override
  String get g5 => 'G5';

  @override
  String get g5D => 'G5D';

  @override
  String get noMalignancy => 'なし';

  @override
  String get pastHistory => '既往歴あり';

  @override
  String get underTreatment => '治療中';

  @override
  String get class4 => 'Class 4';

  @override
  String get class5 => 'Class 5';

  @override
  String get class6 => 'Class 6';

  @override
  String get formErrorMessage => '入力してください。';

  @override
  String get invalidValueMessage => '適切な値を入力してください。';

  @override
  String get ok => 'OK';

  @override
  String get analysisDefaultErrorMessage => '入力データを確認してください。';

  @override
  String get analysisNullErrorMessage => '数値入力を確認してください。';

  @override
  String get analysisLesionErrorMessage => '動脈病変の領域選択を確認してください。';

  @override
  String get references => '参考文献';

  @override
  String get about => 'このアプリについて';

  @override
  String get tapToOpenLink => '論文サイトを開きます。';

  @override
  String get appLegalese => '2022 発行: 特定非営利法人日本血管外科学会、JCLIMB委員会、ソフトウェア制作: 宮原和洋';

  @override
  String get language => '言語';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get analysis => 'リスク解析';

  @override
  String get result => '予測リスク';

  @override
  String get gnri => 'GNRI (Geriatric Nutritional Risk Index)';

  @override
  String get gnriDesctiption => '栄養リスク指標';

  @override
  String get predicted30DAD => '予測30日死亡・大切断率';

  @override
  String get predicted30DADDescription => '血行再建後30日以内の死亡もしくは大切断率の予測';

  @override
  String get predicted30DMALE => '予測30日MALE発生率';

  @override
  String get predicted30DMALEDescription => '血行再建後30日以内のMALE (Major Adverse Limb Event)の発生予測\n*MALE: 主要有害下肢事故（大切断/新たな急性ないし慢性下肢虚血）';

  @override
  String get predicted2yrOS => '予測2年OS';

  @override
  String get predicted2yrOSDescription => '血行再建後２年全生存率の予測';

  @override
  String get predicted2yrAFS => '予測2年AFS';

  @override
  String get predicted2yrAFSDescription => '血行再建後2年大切断回避生存率の予測';

  @override
  String get gnriNoRisk => 'リスクなし';

  @override
  String get gnriLowRisk => '軽度栄養リスク';

  @override
  String get gnriModerateRisk => '中等度栄養リスク';

  @override
  String get gntiMajorRisk => '高度栄養リスク';

  @override
  String get osLowRisk => '低リスク';

  @override
  String get osMediumRisk => '中等度リスク';

  @override
  String get osHighRisk => '高リスク';

  @override
  String get appTerms => '利用規約';

  @override
  String get refreshButtonLabel => '解答画面を初期化する';

  @override
  String get summaryButtonLabel => '設問一覧を表示する';
}
