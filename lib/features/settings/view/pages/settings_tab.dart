import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/build_show_toast.dart';
import 'package:nwara_store_desktop/features/settings/viewmodel/create_backup_cubit.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الإعدادات"), centerTitle: false,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              BlocProvider(
                create: (context) => CreateBackupCubit(),
                child: BlocConsumer<CreateBackupCubit, CreateBackupState>(
                  listener: (context, state) {
                    if(state is CreateBackupSuccess){
                      ScaffoldMessenger.of(context).showSnackBar(

                        SnackBar(
                          action: SnackBarAction(
                              label: "فتح المجلد",
                              onPressed: () async{
                                final String filePath = state.file.absolute.path;
                                try{
                                  if (Platform.isWindows) {
                                    await Process.run('explorer', ['/select,', filePath]);
                                  } else if (Platform.isMacOS) {
                                    await Process.run('open', ['-R', filePath]);
                                  }
                                }catch(e){
                                  buildShowToast("حدث خطأ اثناء فتح المجلد");
                                  throw(e.toString());
                                }
                               
                              },)

                            ,
                            content: Text("تم انشاء النسخه الاحتياطيه بنجاح في المسار: ${state.file.absolute.path}"), backgroundColor: Colors.green),
                      );
                    } else if(state is CreateBackupFailure){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state is CreateBackupLoading){
                      return CircularProgressIndicator();
                    }else{
                      return ElevatedButton(
                          onPressed: () {
                            context.read<CreateBackupCubit>().createBackup();
                          },
                          child: Text("عمل نسخه احتياطيه"));
                    }

                  },
                ),
              ),
              Spacer(),
              Center(
                child: Text("Nwara Store Desktop App v0.1.0 (Beta)", style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                )

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
