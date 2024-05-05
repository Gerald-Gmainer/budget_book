import { NgModule } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@NgModule({
  imports: [CommonModule],
  exports: [MatCardModule, MatButtonModule, MatIconModule, MatInputModule, MatFormFieldModule, ReactiveFormsModule],
})
export class SharedModule {}
