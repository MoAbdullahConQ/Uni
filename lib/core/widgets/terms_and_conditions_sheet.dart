import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

// static terms & conditions content shown as a draggable bottom sheet
class TermsAndConditionsSheet extends StatelessWidget {
  const TermsAndConditionsSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TermsAndConditionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              const Text('الشروط والأحكام', style: TextStyles.bold18),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.borderColor),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  child: const _TermsBody(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TermsBody extends StatelessWidget {
  const _TermsBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TermsSection(
          title: '1. استخدام التطبيق',
          body:
              'تطبيق جامعتي مخصص لمساعدة طلاب الثانوية العامة على استكشاف '
              'الجامعات والكليات المصرية واتخاذ قرار مناسب بشأن التعليم '
              'الجامعي. باستخدامك للتطبيق، فإنك توافق على استخدامه للأغراض '
              'الشخصية وغير التجارية فقط.',
        ),
        _TermsSection(
          title: '2. حسابك الشخصي',
          body:
              'أنت مسؤول عن الحفاظ على سرية بيانات الدخول الخاصة بحسابك. '
              'يجب أن تكون المعلومات التي تقدمها عند التسجيل (الاسم، البريد '
              'الإلكتروني، البيانات الدراسية) صحيحة ودقيقة، حيث تُستخدم '
              'لتخصيص النتائج والاقتراحات المقدمة لك.',
        ),
        _TermsSection(
          title: '3. دقة المعلومات',
          body:
              'نسعى لتقديم معلومات دقيقة وحديثة عن الجامعات والكليات وشروط '
              'القبول، إلا أن هذه المعلومات قد تتغير من جهة الجامعات أو وزارة '
              'التعليم العالي. لا يُعتبر التطبيق مصدرًا رسميًا بديلاً عن '
              'الإعلانات الرسمية لتنسيق الجامعات.',
        ),
        _TermsSection(
          title: '4. الخصوصية وحماية البيانات',
          body:
              'نلتزم بعدم مشاركة بياناتك الشخصية مع أي طرف ثالث دون موافقتك، '
              'باستثناء ما يلزم لتقديم الخدمة (مثل خوادم التطبيق). يمكنك طلب '
              'حذف حسابك وبياناتك في أي وقت من خلال صفحة الحساب.',
        ),
        _TermsSection(
          title: '5. سلوك المستخدم',
          body:
              'يُمنع استخدام التطبيق في أي نشاط غير قانوني، أو محاولة الوصول '
              'غير المصرح به لأنظمة التطبيق، أو إدخال بيانات مضللة بقصد '
              'الإضرار بالخدمة أو بمستخدمين آخرين.',
        ),
        _TermsSection(
          title: '6. التعديلات على الشروط',
          body:
              'قد يتم تحديث هذه الشروط والأحكام من وقت لآخر. استمرارك في '
              'استخدام التطبيق بعد أي تحديث يُعد موافقة منك على الشروط '
              'المعدّلة.',
        ),
        _TermsSection(
          title: '7. التواصل معنا',
          body:
              'لأي استفسار يخص هذه الشروط أو بياناتك الشخصية، يمكنك التواصل '
              'معنا من خلال صفحة "تواصل معنا" داخل التطبيق.',
        ),
      ],
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
