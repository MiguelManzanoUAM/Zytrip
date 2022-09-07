class TripsResearchController < ApplicationController
  def survey
  end

  def results

    @trips = Trip.all

    # ------------ 1) destination ------------ #

    if (params[:iberic] || params[:europe] || params[:africa] || params[:asia] || params[:america])
      
      @message_destination = "Se tendra en cuenta el destino del viaje"
      @destination_trips = []

      if params[:iberic]
        @trips.each do |t|
          if t.preference.destination_spain?
            @destination_trips << t
          end
        end
      elsif params[:europe]
        @trips.each do |t|
          if t.preference.destination_europe?
            @destination_trips << t
          end
        end
      elsif params[:america]
        @trips.each do |t|
          if t.preference.destination_america?
            @destination_trips << t
          end
        end
      elsif params[:africa]
        @trips.each do |t|
          if t.preference.destination_africa?
            @destination_trips << t
          end
        end
      else
        @trips.each do |t|
          if t.preference.destination_asia?
            @destination_trips << t
          end
        end
      end

      # ------------ 2) budget ------------ #

      if (params[:maxp300] || params[:betwp35] || params[:betwp510] || params[:minp1000])

        @budget_trips = []
        @message_budget = "Se tendra en cuenta el presupuesto"

        if params[:maxp300]
          @destination_trips.each do |t|
            if t.preference.budget_low?
              @budget_trips << t
            end
          end
        elsif params[:betwp35]
          @destination_trips.each do |t|
            if t.preference.budget_medium?
              @budget_trips << t
            end
          end
        elsif params[:betwp510]
          @destination_trips.each do |t|
            if t.preference.budget_high?
              @budget_trips << t
            end
          end
        else
          @destination_trips.each do |t|
            if t.preference.budget_expensive?
              @budget_trips << t
            end
          end
        end

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []
          @message_duration = "Se tendra en cuenta la duracion del viaje"

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @message_duration = "No se tendra en cuenta la duracion del viaje"
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end
        end


      # ------------ 2) No budget ------------ #
      else

        @budget_trips = @destination_trips
        @message_budget = "No se tendra en cuenta el presupuesto"

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []
          @message_duration = "Se tendra en cuenta la duracion del viaje"

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @message_duration = "No se tendra en cuenta la duracion del viaje"
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end

        end

      end


    # ------------ 1) No destination ------------ #
    else
      @message_destination = "No se tendra en cuenta el destino del viaje"
      @destination_trips = Trip.all

      # ------------ 2) budget ------------ #

      if (params[:maxp300] || params[:betwp35] || params[:betwp510] || params[:minp1000])

        @budget_trips = []
        @message_budget = "Se tendra en cuenta el presupuesto"

        if params[:maxp300]
          @destination_trips.each do |t|
            if t.preference.budget_low?
              @budget_trips << t
            end
          end
        elsif params[:betwp35]
          @destination_trips.each do |t|
            if t.preference.budget_medium?
              @budget_trips << t
            end
          end
        elsif params[:betwp510]
          @destination_trips.each do |t|
            if t.preference.budget_high?
              @budget_trips << t
            end
          end
        else
          @destination_trips.each do |t|
            if t.preference.budget_expensive?
              @budget_trips << t
            end
          end
        end

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []
          @message_duration = "Se tendra en cuenta la duracion del viaje"

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @message_duration = "No se tendra en cuenta la duracion del viaje"
          @duration = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end
        end


      # ------------ 2) No budget ------------ #
      else

        @budget_trips = @destination_trips
        @message_budget = "No se tendra en cuenta el presupuesto"

        # ------------ 3) duration ------------ #

        if (params[:maxd3] || params[:betwd35] || params[:betwd57] || params[:minweek])

          @duration_trips = []
          @message_duration = "Se tendra en cuenta la duracion del viaje"

          if params[:maxd3]
            @budget_trips.each do |t|
              if t.preference.duration_short?
                @duration_trips << t
              end
            end
          elsif params[:betwd35]
            @budget_trips.each do |t|
              if t.preference.duration_ordinary?
                @duration_trips << t
              end
            end
          elsif params[:betwd57]
            @budget_trips.each do |t|
              if t.preference.duration_long?
                @duration_trips << t
              end
            end
          else
            @budget_trips.each do |t|
              if t.preference.duration_overlong?
                @duration_trips << t
              end
            end
          end

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end

        # ------------ 3) No duration ------------ #
        else
          @message_duration = "No se tendra en cuenta la duracion del viaje"
          @duration_trips = @budget_trips

          # ------------ 4) Services ------------ #

          if (params[:gastronomy] || params[:lodging] || params[:activities])

            @services_trips = []
            @message_services = "Se tiene en cuenta alguna preferencia en los servicios del viaje"

            if params[:gastronomy]
              @duration_trips.each do |t|
                if t.preference.remarkable_gastronomy?
                  @services_trips << t
                end
              end
            elsif params[:lodging]
              @duration_trips.each do |t|
                if t.preference.remarkable_lodging?
                  @services_trips << t
                end
              end
            else
              @duration_trips.each do |t|
                if t.preference.remarkable_activities?
                  @services_trips << t
                end
              end
            end

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            end

          # ------------ 4) No services ------------ #
          else
            @message_services = "No se tiene en cuenta alguna preferencia en los servicios del viaje"
            @services_trips = @duration_trips

            # ------------ 5) Companies ------------ #

            if (params[:family] || params[:romantic] || params[:friends] || params[:alone] || params[:people])

              @company_trips = []
              @message_company = "Se especifica el tipo de compañía deseada"

              if params[:family]
                @services_trips.each do |t|
                  if t.preference.family_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:romantic]
                @services_trips.each do |t|
                  if t.preference.partner_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:friends]
                @services_trips.each do |t|
                  if t.preference.friends_as_company?
                    @company_trips << t
                  end
                end
              elsif params[:alone]
                @services_trips.each do |t|
                  if t.preference.alone_as_company?
                    @company_trips << t
                  end
                end
              else
                @services_trips.each do |t|
                  if t.preference.new_people_as_company?
                    @company_trips << t
                  end
                end
              end

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end

            # ------------ 5) No companies ------------ #
            else
              @message_company = "No se especifica el tipo de compañía deseada"
              @company_trips = @services_trips

              # ------------ 6) Topic ------------ #

              if(params[:beach] || params[:nature] || params[:tourism])

                @topic_trips = []
                @message_topic = "Se especifica la temática principal del viaje"

                if params[:beach]
                  @company_trips.each do |t|
                    if t.preference.beach_as_main_topic?
                      @topic_trips << t
                    end
                  end
                elsif params[:nature]
                  @company_trips.each do |t|
                    if t.preference.nature_as_main_topic?
                      @topic_trips << t
                    end
                  end
                else
                  @company_trips.each do |t|
                    if t.preference.tourism_as_main_topic?
                      @topic_trips << t
                    end
                  end
                end

                @result_trips = @topic_trips

              else
                @message_topic = "No se especifica la temática principal del viaje"
                @result_trips = @company_trips
              end
              
            end
          end
        end
      end
    end
  end
end
