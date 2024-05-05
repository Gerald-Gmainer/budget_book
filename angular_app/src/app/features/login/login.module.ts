import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LoginComponent } from './containers/login/login.component';
import { LoginViewComponent } from './components/login-view/login-view.component';
import { ReactiveFormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { SharedModule } from '@shared/shared.module';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [{ path: '', component: LoginComponent }];

@NgModule({
  declarations: [LoginComponent, LoginViewComponent],
  imports: [CommonModule, ReactiveFormsModule, SharedModule, RouterModule.forChild(routes)],
})
export class LoginModule {}
